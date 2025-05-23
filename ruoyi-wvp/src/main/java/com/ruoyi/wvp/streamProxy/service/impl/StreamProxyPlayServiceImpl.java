package com.ruoyi.wvp.streamProxy.service.impl;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.conf.DynamicTask;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.media.bean.MediaInfo;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.event.hook.Hook;
import com.ruoyi.wvp.media.event.hook.HookSubscribe;
import com.ruoyi.wvp.media.event.hook.HookType;
import com.ruoyi.wvp.media.event.media.MediaArrivalEvent;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.service.bean.ErrorCallback;
import com.ruoyi.wvp.service.bean.InviteErrorCode;
import com.ruoyi.wvp.streamProxy.bean.StreamProxy;
import com.ruoyi.wvp.mapper.StreamProxyMapper;
import com.ruoyi.wvp.streamProxy.service.IStreamProxyPlayService;
import com.ruoyi.common.enums.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;

import javax.sip.message.Response;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 视频代理业务
 */
@Slf4j
@Service
@DS("master")
public class StreamProxyPlayServiceImpl implements IStreamProxyPlayService {

    @Autowired
    private StreamProxyMapper streamProxyMapper;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private HookSubscribe subscribe;

    @Autowired
    private DynamicTask dynamicTask;

    @Autowired
    private UserSetting userSetting;

    private ConcurrentHashMap<Integer, ErrorCallback<StreamInfo>> callbackMap = new ConcurrentHashMap<>();

    private ConcurrentHashMap<Integer, StreamInfo> streamInfoMap = new ConcurrentHashMap<>();

    /**
     * 流到来的处理
     */
    @Async("taskExecutor")
    @Transactional
    @EventListener
    public void onApplicationEvent(MediaArrivalEvent event) {
        if ("rtsp".equals(event.getSchema())) {
            StreamProxy streamProxy = streamProxyMapper.selectOneByAppAndStream(event.getApp(), event.getStream());
            if (streamProxy != null) {
                ErrorCallback<StreamInfo> callback = callbackMap.remove(streamProxy.getId());
                StreamInfo streamInfo = streamInfoMap.remove(streamProxy.getId());
                if (callback != null && streamInfo != null) {
                    callback.run(InviteErrorCode.SUCCESS.getCode(), InviteErrorCode.SUCCESS.getMsg(), streamInfo);
                }
            }
        }
    }

    @Override
    public void start(int id, ErrorCallback<StreamInfo> callback) {
        StreamProxy streamProxy = streamProxyMapper.select(id);
        if (streamProxy == null) {
            throw new ControllerException(ErrorCode.ERROR404.getCode(), "代理信息未找到");
        }
        StreamInfo streamInfo = startProxy(streamProxy);
        if (streamInfo == null) {
            callback.run(Response.BUSY_HERE, "busy here", null);
            return;
        }
        callbackMap.put(id, callback);
        streamInfoMap.put(id, streamInfo);

        MediaServer mediaServer = mediaServerService.getOne(streamProxy.getMediaServerId());
        if (mediaServer != null) {
            MediaInfo mediaInfo = mediaServerService.getMediaInfo(mediaServer, streamProxy.getApp(), streamProxy.getStream());
            if (mediaInfo != null) {
                callbackMap.remove(id);
                streamInfoMap.remove(id);
                callback.run(InviteErrorCode.SUCCESS.getCode(), InviteErrorCode.SUCCESS.getMsg(), streamInfo);
            }
        }
    }

    @Override
    public StreamInfo start(int id, Boolean record, ErrorCallback<StreamInfo> callback) {
        StreamProxy streamProxy = streamProxyMapper.select(id);
        if (streamProxy == null) {
            throw new ControllerException(ErrorCode.ERROR404.getCode(), "代理信息未找到");
        }
        if (record != null) {
            streamProxy.setEnableMp4(record);
        }

        StreamInfo streamInfo = startProxy(streamProxy);
        if (callback != null) {
            // 设置流超时的定时任务
            String timeOutTaskKey = UUID.randomUUID().toString();
            Hook rtpHook = Hook.getInstance(HookType.on_media_arrival, streamProxy.getApp(), streamProxy.getStream(), streamInfo.getMediaServer().getId());
            dynamicTask.startDelay(timeOutTaskKey, () -> {
                // 收流超时
                subscribe.removeSubscribe(rtpHook);
                callback.run(InviteErrorCode.ERROR_FOR_STREAM_TIMEOUT.getCode(), InviteErrorCode.ERROR_FOR_STREAM_TIMEOUT.getMsg(), streamInfo);
            }, userSetting.getPlayTimeout());

            // 开启流到来的监听
            subscribe.addSubscribe(rtpHook, (hookData) -> {
                dynamicTask.stop(timeOutTaskKey);
                // hook响应
                callback.run(InviteErrorCode.SUCCESS.getCode(), InviteErrorCode.SUCCESS.getMsg(), streamInfo);
                subscribe.removeSubscribe(rtpHook);
            });
        }
        return streamInfo;
    }

    @Override
    public StreamInfo startProxy(StreamProxy streamProxy){
        if (!streamProxy.isEnable()) {
            return null;
        }
        MediaServer mediaServer;
        String mediaServerId = streamProxy.getRelatesMediaServerId();
        if (mediaServerId == null) {
            mediaServer = mediaServerService.getMediaServerForMinimumLoad(null);
        }else {
            mediaServer = mediaServerService.getOne(mediaServerId);
        }
        if (mediaServer == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), mediaServerId == null?"未找到可用的媒体节点":"未找到节点" + mediaServerId);
        }
        StreamInfo streamInfo = mediaServerService.startProxy(mediaServer, streamProxy);
//        if (mediaServerId == null || !mediaServerId.equals(mediaServer.getId())) {
            streamProxy.setMediaServerId(mediaServer.getId());
            streamProxyMapper.addStream(streamProxy);
//        }
        return streamInfo;
    }

    @Override
    public void stop(int id) {
        StreamProxy streamProxy = streamProxyMapper.select(id);
        if (streamProxy == null) {
            throw new ControllerException(ErrorCode.ERROR404.getCode(), "代理信息未找到");
        }
        stopProxy(streamProxy);
    }

    @Override
    public void stopProxy(StreamProxy streamProxy){

        String mediaServerId = streamProxy.getMediaServerId();
        Assert.notNull(mediaServerId, "代理节点不存在");

        MediaServer mediaServer = mediaServerService.getOne(mediaServerId);
        if (mediaServer == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "媒体节点不存在");
        }
        if (ObjectUtils.isEmpty(streamProxy.getStreamKey())) {
            mediaServerService.closeStreams(mediaServer, streamProxy.getApp(), streamProxy.getStream());
        }else {
            mediaServerService.stopProxy(mediaServer, streamProxy.getStreamKey());
        }
        streamProxyMapper.removeStream(streamProxy.getId());
    }

}
