package com.ruoyi.wvp.controller;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.wvp.common.InviteSessionType;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.bean.DeviceChannel;
import com.ruoyi.wvp.gb28181.bean.SsrcTransaction;
import com.ruoyi.wvp.gb28181.service.IDeviceChannelService;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.service.IInviteStreamService;
import com.ruoyi.wvp.gb28181.service.IPlayService;
import com.ruoyi.wvp.gb28181.session.SipInviteSessionManager;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.service.bean.InviteErrorCode;
import com.ruoyi.wvp.utils.DateUtil;
import com.ruoyi.wvp.vmanager.bean.AudioBroadcastResult;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.StreamContent;
import com.ruoyi.wvp.vmanager.bean.WVPResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import javax.servlet.http.HttpServletRequest;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.UUID;


/**
 * 国标设备点播
 *
 * @author lin
 */
@Slf4j
@RestController
@RequestMapping("/api/play")
public class PlayController extends BaseController {

    @Autowired
    private SipInviteSessionManager sessionManager;

    @Autowired
    private IInviteStreamService inviteStreamService;

    @Autowired
    private DeferredResultHolder resultHolder;

    @Autowired
    private IPlayService playService;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private UserSetting userSetting;

    @Autowired
    private IDeviceService deviceService;

    @Autowired
    private IDeviceChannelService deviceChannelService;

    /**
     * 播放视频
     *
     * @param request
     * @param deviceId 设备国标编号
     * @param channelId 通道国标编号
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:play:start')")
    @GetMapping("/start/{deviceId}/{channelId}")
    public DeferredResult<WVPResult<StreamContent>> play(HttpServletRequest request, @PathVariable String deviceId, @PathVariable String channelId) {
        log.info("[开始点播] deviceId：{}, channelId：{}, ", deviceId, channelId);
        Assert.notNull(deviceId, "设备国标编号不可为NULL");
        Assert.notNull(channelId, "通道国标编号不可为NULL");
        // 获取可用的zlm
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        Assert.notNull(device, "设备不存在");
        DeviceChannel channel = deviceChannelService.getOne(deviceId, channelId);
        Assert.notNull(channel, "通道不存在");
        MediaServer newMediaServerItem = playService.getNewMediaServerItem(device);

        RequestMessage requestMessage = new RequestMessage();
        String key = DeferredResultHolder.CALLBACK_CMD_PLAY + deviceId + channelId;
        requestMessage.setKey(key);
        String uuid = UUID.randomUUID().toString();
        requestMessage.setId(uuid);
        DeferredResult<WVPResult<StreamContent>> result = new DeferredResult<>(userSetting.getPlayTimeout().longValue());

        result.onTimeout(() -> {
            log.info("[点播等待超时] deviceId：{}, channelId：{}, ", deviceId, channelId);
            // 释放rtpserver
            WVPResult<StreamInfo> wvpResult = new WVPResult<>();
            wvpResult.setCode(ErrorCode.ERROR100.getCode());
            wvpResult.setMsg("点播超时");
            requestMessage.setData(wvpResult);
            resultHolder.invokeAllResult(requestMessage);
            inviteStreamService.removeInviteInfoByDeviceAndChannel(InviteSessionType.PLAY, channel.getId());
            deviceChannelService.stopPlay(channel.getId());
        });

        // 录像查询以channelId作为deviceId查询
        resultHolder.put(key, uuid, result);

        playService.play(newMediaServerItem, deviceId, channelId, null, (code, msg, streamInfo) -> {
            WVPResult<StreamContent> wvpResult = new WVPResult<>();
            if (code == InviteErrorCode.SUCCESS.getCode()) {
                wvpResult.setCode(ErrorCode.SUCCESS.getCode());
                wvpResult.setMsg(ErrorCode.SUCCESS.getMsg());

                if (streamInfo != null) {
                    if (userSetting.getUseSourceIpAsStreamIp()) {
                        streamInfo = streamInfo.clone();//深拷贝
                        String host;
                        try {
                            URL url = new URL(request.getRequestURL().toString());
                            host = url.getHost();
                        } catch (MalformedURLException e) {
                            host = request.getLocalAddr();
                        }
                        streamInfo.channgeStreamIp(host);
                    }
                    if (!ObjectUtils.isEmpty(newMediaServerItem.getTranscodeSuffix()) && !"null".equalsIgnoreCase(newMediaServerItem.getTranscodeSuffix())) {
                        streamInfo.setStream(streamInfo.getStream() + "_" + newMediaServerItem.getTranscodeSuffix());
                    }
                    wvpResult.setData(new StreamContent(streamInfo));
                } else {
                    wvpResult.setCode(code);
                    wvpResult.setMsg(msg);
                }
            } else {
                wvpResult.setCode(code);
                wvpResult.setMsg(msg);
            }
            requestMessage.setData(wvpResult);
            // 此处必须释放所有请求
            resultHolder.invokeAllResult(requestMessage);
        });
        return result;
    }

    /**
     * 停止点播
     *
     * @param deviceId  设备国标编号
     * @param channelId 通道国标编号
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:play:stop')")
    @GetMapping("/stop/{deviceId}/{channelId}")
    public AjaxResult playStop(@PathVariable String deviceId, @PathVariable String channelId) {
        log.debug(String.format("设备预览/回放停止API调用，streamId：%s_%s", deviceId, channelId));
        if (deviceId == null || channelId == null) {
            throw new ControllerException(ErrorCode.ERROR400);
        }

        Device device = deviceService.getDeviceByDeviceId(deviceId);
        DeviceChannel channel = deviceChannelService.getOneForSource(deviceId, channelId);
        Assert.notNull(device, "设备不存在");
        Assert.notNull(channel, "通道不存在");
        String streamId = String.format("%s_%s", device.getDeviceId(), channel.getDeviceId());
        playService.stop(InviteSessionType.PLAY, device, channel, streamId);
        return success();
    }

    /**
     * 结束转码
     *
     * @param key 视频流key
     * @param mediaServerId 流媒体服务ID
     */
    @PostMapping("/convertStop/{key}")
    public void playConvertStop(@PathVariable String key, String mediaServerId) {
        if (mediaServerId == null) {
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "流媒体：" + mediaServerId + "不存在");
        }
        MediaServer mediaInfo = mediaServerService.getOne(mediaServerId);
        if (mediaInfo == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "使用的流媒体已经停止运行");
        } else {
            Boolean deleted = mediaServerService.delFFmpegSource(mediaInfo, key);
            if (!deleted) {
                throw new ControllerException(ErrorCode.ERROR100);
            }
        }
    }

    /**
     * 语音广播
     *
     * @param deviceId 设备国标编号
     * @param channelId 通道国标编号
     * @param timeout 推流超时时间(秒)
     * @param broadcastMode
     * @return
     */
    @GetMapping("/broadcast/{deviceId}/{channelId}")
    @PostMapping("/broadcast/{deviceId}/{channelId}")
    public AudioBroadcastResult broadcastApi(@PathVariable String deviceId, @PathVariable String channelId, Integer timeout, Boolean broadcastMode) {
        if (log.isDebugEnabled()) {
            log.debug("语音广播API调用");
        }
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        if (device == null) {
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "未找到设备： " + deviceId);
        }
        DeviceChannel channel = deviceChannelService.getOne(deviceId, channelId);
        if (channel == null) {
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "未找到通道： " + channelId);
        }

        return playService.audioBroadcast(device, channel, broadcastMode);

    }

    /**
     * 停止语音广播
     *
     * @param deviceId 设备Id
     * @param channelId 通道Id
     */
    @GetMapping("/broadcast/stop/{deviceId}/{channelId}")
    @PostMapping("/broadcast/stop/{deviceId}/{channelId}")
    public void stopBroadcast(@PathVariable String deviceId, @PathVariable String channelId) {
        if (log.isDebugEnabled()) {
            log.debug("停止语音广播API调用");
        }
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        Assert.notNull(device, "设备不存在");
        DeviceChannel channel = deviceChannelService.getOne(deviceId, channelId);
        Assert.notNull(channel, "通道不存在");
        playService.stopAudioBroadcast(device, channel);
    }

    @GetMapping("/ssrc")
    public JSONObject getSSRC() {
        if (log.isDebugEnabled()) {
            log.debug("获取所有的ssrc");
        }
        JSONArray objects = new JSONArray();
        List<SsrcTransaction> allSsrc = sessionManager.getAll();
        for (SsrcTransaction transaction : allSsrc) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("deviceId", transaction.getDeviceId());
            jsonObject.put("channelId", transaction.getChannelId());
            jsonObject.put("ssrc", transaction.getSsrc());
            jsonObject.put("streamId", transaction.getStream());
            objects.add(jsonObject);
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", objects);
        jsonObject.put("count", objects.size());
        return jsonObject;
    }

    /**
     * 创建快照 - 抓拍
     *
     * @param deviceId 设备国标编号
     * @param channelId 通道国标编号
     * @return
     */
    @GetMapping("/snap")
    public DeferredResult<String> getSnap(String deviceId, String channelId) {
        if (log.isDebugEnabled()) {
            log.debug("获取截图: {}/{}", deviceId, channelId);
        }

        DeferredResult<String> result = new DeferredResult<>(3 * 1000L);
        String key = DeferredResultHolder.CALLBACK_CMD_SNAP + deviceId;
        String uuid = UUID.randomUUID().toString();
        resultHolder.put(key, uuid, result);

        RequestMessage message = new RequestMessage();
        message.setKey(key);
        message.setId(uuid);

        String fileName = deviceId + "_" + channelId + "_" + DateUtil.getNowForUrl() + ".jpg";
        playService.getSnap(deviceId, channelId, fileName, (code, msg, data) -> {
            if (code == InviteErrorCode.SUCCESS.getCode()) {
                message.setData(data);
            } else {
                message.setData(WVPResult.fail(code, msg));
            }
            resultHolder.invokeResult(message);
        });
        return result;
    }

}

