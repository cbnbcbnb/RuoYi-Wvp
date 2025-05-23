package com.ruoyi.wvp.streamPush.service.impl;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.conf.DynamicTask;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.wvp.media.bean.MediaInfo;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.media.zlm.dto.StreamAuthorityInfo;
import com.ruoyi.wvp.service.bean.ErrorCallback;
import com.ruoyi.wvp.service.bean.MessageForPushChannel;
import com.ruoyi.wvp.service.redisMsg.IRedisRpcService;
import com.ruoyi.wvp.service.redisMsg.RedisPushStreamResponseListener;
import com.ruoyi.wvp.storager.IRedisCatchStorage;
import com.ruoyi.wvp.streamPush.bean.StreamPush;
import com.ruoyi.wvp.mapper.StreamPushMapper;
import com.ruoyi.wvp.streamPush.service.IStreamPushPlayService;
import com.ruoyi.common.enums.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.UUID;

@Service
@Slf4j
@DS("master")
public class StreamPushPlayServiceImpl implements IStreamPushPlayService {

    @Autowired
    private StreamPushMapper streamPushMapper;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private IRedisCatchStorage redisCatchStorage;

    @Autowired
    private UserSetting userSetting;

    @Autowired
    private DynamicTask dynamicTask;

    @Autowired
    private IRedisRpcService redisRpcService;

    @Autowired
    private RedisPushStreamResponseListener redisPushStreamResponseListener;

    @Override
    public void start(Integer id, ErrorCallback<StreamInfo> callback, String platformDeviceId, String platformName ) {
        StreamPush streamPush = streamPushMapper.queryOne(id);
        Assert.notNull(streamPush, "推流信息未找到");

        MediaServer mediaServer = mediaServerService.getOne(streamPush.getMediaServerId());
        Assert.notNull(mediaServer, "节点" + streamPush.getMediaServerId() + "未找到");
        MediaInfo mediaInfo = mediaServerService.getMediaInfo(mediaServer, streamPush.getApp(), streamPush.getStream());
        if (mediaInfo != null) {
            String callId = null;
            StreamAuthorityInfo streamAuthorityInfo = redisCatchStorage.getStreamAuthorityInfo(streamPush.getApp(), streamPush.getStream());
            if (streamAuthorityInfo != null) {
                callId = streamAuthorityInfo.getCallId();
            }
            callback.run(ErrorCode.SUCCESS.getCode(), ErrorCode.SUCCESS.getMsg(), mediaServerService.getStreamInfoByAppAndStream(mediaServer,
                    streamPush.getApp(), streamPush.getStream(), mediaInfo, callId));
            if (!streamPush.isPushing()) {
                streamPush.setPushing(true);
                streamPushMapper.update(streamPush);
            }
            return;
        }
        Assert.isTrue(streamPush.isStartOfflinePush(), "通道未推流");
        // 发送redis消息以使设备上线，流上线后被
        log.info("[ app={}, stream={} ]通道未推流，发送redis信息控制设备开始推流", streamPush.getApp(), streamPush.getStream());
        MessageForPushChannel messageForPushChannel = MessageForPushChannel.getInstance(1,
                streamPush.getApp(), streamPush.getStream(), streamPush.getGbDeviceId(), platformDeviceId,
                platformName, userSetting.getServerId(), null);
        redisCatchStorage.sendStreamPushRequestedMsg(messageForPushChannel);
        // 设置超时
        String timeOutTaskKey = UUID.randomUUID().toString();
        dynamicTask.startDelay(timeOutTaskKey, () -> {
            redisRpcService.unPushStreamOnlineEvent(streamPush.getApp(), streamPush.getStream());
            log.info("[ app={}, stream={} ] 等待设备开始推流超时", streamPush.getApp(), streamPush.getStream());
            callback.run(ErrorCode.ERROR100.getCode(), "timeout", null);

        }, userSetting.getPlatformPlayTimeout());
        //
        long key = redisRpcService.onStreamOnlineEvent(streamPush.getApp(), streamPush.getStream(), (streamInfo) -> {
            dynamicTask.stop(timeOutTaskKey);
            if (streamInfo == null) {
                log.warn("等待推流得到结果未空： {}/{}", streamPush.getApp(), streamPush.getStream());
                callback.run(ErrorCode.ERROR100.getCode(), "fail", null);
            }else {
                callback.run(ErrorCode.SUCCESS.getCode(), ErrorCode.SUCCESS.getMsg(), streamInfo);
            }
        });
        // 添加回复的拒绝或者错误的通知
        // redis消息例如： PUBLISH VM_MSG_STREAM_PUSH_RESPONSE  '{"code":1,"msg":"失败","app":"1","stream":"2"}'
        redisPushStreamResponseListener.addEvent(streamPush.getApp(), streamPush.getStream(), response -> {
            if (response.getCode() != 0) {
                dynamicTask.stop(timeOutTaskKey);
                redisRpcService.unPushStreamOnlineEvent(streamPush.getApp(), streamPush.getStream());
                redisRpcService.removeCallback(key);
                callback.run(response.getCode(), response.getMsg(), null);
            }
        });
    }
}
