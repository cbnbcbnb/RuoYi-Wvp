package com.ruoyi.wvp.controller;

import com.ruoyi.wvp.common.VideoManagerConstants;
import com.ruoyi.wvp.conf.DynamicTask;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.SendRtpInfo;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.event.hook.Hook;
import com.ruoyi.wvp.media.event.hook.HookSubscribe;
import com.ruoyi.wvp.media.event.hook.HookType;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.service.ISendRtpServerService;
import com.ruoyi.wvp.service.bean.SSRCInfo;
import com.ruoyi.wvp.utils.redis.RedisUtil;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.OtherRtpSendInfo;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * 第三方服务对接
 */
@SuppressWarnings("rawtypes")
@Slf4j
@RestController
@RequestMapping("/api/rtp")
public class RtpController {

    @Autowired
    private ISendRtpServerService sendRtpServerService;

    @Autowired
    private HookSubscribe hookSubscribe;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private UserSetting userSetting;

    @Autowired
    private DynamicTask dynamicTask;

    @Autowired
    private RedisTemplate<Object, Object> redisTemplate;


    /**
     * 第三方服务对接->开启收流和获取发流信息
     *
     * @param isSend 是否发送，false时只开启收流， true同时返回推流信息
     * @param ssrc 整个过程的唯一标识，为了与后续接口关联
     * @param callId 来源流的SSRC，不传则不校验来源ssrc
     * @param stream 形成的流的ID
     * @param tcpMode 收流模式， 0为UDP， 1为TCP被动
     * @param callBack 回调地址，如果收流超时会通道回调通知，回调为get请求，参数为callId
     * @return
     */
    @GetMapping(value = "/receive/open")
    @ResponseBody
    public OtherRtpSendInfo openRtpServer(Boolean isSend, @RequestParam(required = false)String ssrc, String callId, String stream, Integer tcpMode, String callBack) {

        log.info("[第三方服务对接->开启收流和获取发流信息] isSend->{}, ssrc->{}, callId->{}, stream->{}, tcpMode->{}, callBack->{}",
                isSend, ssrc, callId, stream, tcpMode==0?"UDP":"TCP被动", callBack);

        MediaServer mediaServer = mediaServerService.getDefaultMediaServer();
        if (mediaServer == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(),"没有可用的MediaServer");
        }
        if (stream == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(),"stream参数不可为空");
        }
        if (isSend != null && isSend && callId == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(),"isSend为true时，CallID不能为空");
        }
        long ssrcInt = 0;
        if (ssrc != null) {
            try {
                ssrcInt = Long.parseLong(ssrc);
            }catch (NumberFormatException e) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(),"ssrc格式错误");
            }
        }
        String receiveKey = VideoManagerConstants.WVP_OTHER_RECEIVE_RTP_INFO + userSetting.getServerId() + "_" + callId + "_"  + stream;
        SSRCInfo ssrcInfoForVideo =  mediaServerService.openRTPServer(mediaServer, stream, ssrcInt + "",false,false, null, false, false, false, tcpMode);
        SSRCInfo ssrcInfoForAudio =  mediaServerService.openRTPServer(mediaServer, stream + "_a", ssrcInt + "", false, false, null, false,false,false, tcpMode);
        if (ssrcInfoForVideo.getPort() == 0 || ssrcInfoForAudio.getPort() == 0) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "获取端口失败");
        }
        // 注册回调如果rtp收流超时则通过回调发送通知
        if (callBack != null) {
            Hook hook = Hook.getInstance(HookType.on_rtp_server_timeout, "rtp", stream, mediaServer.getId());
            // 订阅 zlm启动事件, 新的zlm也会从这里进入系统
            hookSubscribe.addSubscribe(hook,
                    (hookData)->{
                        if (stream.equals(hookData.getStream())) {
                            log.info("[开启收流和获取发流信息] 等待收流超时 callId->{}, 发送回调", callId);
                            OkHttpClient.Builder httpClientBuilder = new OkHttpClient.Builder();
                            OkHttpClient client = httpClientBuilder.build();
                            String url = callBack + "?callId="  + callId;
                            Request request = new Request.Builder().get().url(url).build();
                            try {
                                client.newCall(request).execute();
                            } catch (IOException e) {
                                log.error("[第三方服务对接->开启收流和获取发流信息] 等待收流超时 callId->{}, 发送回调失败", callId, e);
                            }
                            hookSubscribe.removeSubscribe(hook);
                        }
                    });
        }
        String key = VideoManagerConstants.WVP_OTHER_SEND_RTP_INFO + userSetting.getServerId() + "_"  + callId;
        OtherRtpSendInfo otherRtpSendInfo = new OtherRtpSendInfo();
        otherRtpSendInfo.setReceiveIp(mediaServer.getSdpIp());
        otherRtpSendInfo.setReceivePortForVideo(ssrcInfoForVideo.getPort());
        otherRtpSendInfo.setReceivePortForAudio(ssrcInfoForAudio.getPort());
        otherRtpSendInfo.setCallId(callId);
        otherRtpSendInfo.setStream(stream);

        // 将信息写入redis中，以备后用
        redisTemplate.opsForValue().set(receiveKey, otherRtpSendInfo);
        if (isSend != null && isSend) {
            // 预创建发流信息
            int portForVideo = sendRtpServerService.getNextPort(mediaServer);
            int portForAudio = sendRtpServerService.getNextPort(mediaServer);

            otherRtpSendInfo.setSendLocalIp(mediaServer.getSdpIp());
            otherRtpSendInfo.setSendLocalPortForVideo(portForVideo);
            otherRtpSendInfo.setSendLocalPortForAudio(portForAudio);
            // 将信息写入redis中，以备后用
            redisTemplate.opsForValue().set(key, otherRtpSendInfo, 300, TimeUnit.SECONDS);
            log.info("[第三方服务对接->开启收流和获取发流信息] 结果，callId->{}， {}", callId, otherRtpSendInfo);
        }
        // 将信息写入redis中，以备后用
        redisTemplate.opsForValue().set(key, otherRtpSendInfo, 300, TimeUnit.SECONDS);
        return otherRtpSendInfo;
    }

    /**
     * 第三方服务对接->关闭收流
     *
     * @param stream 流的ID
     */
    @GetMapping(value = "/receive/close")
    @ResponseBody
    public void closeRtpServer(String stream) {
        log.info("[第三方服务对接->关闭收流] stream->{}", stream);
        MediaServer mediaServerItem = mediaServerService.getDefaultMediaServer();
        mediaServerService.closeRTPServer(mediaServerItem, stream);
        mediaServerService.closeRTPServer(mediaServerItem, stream+ "_a");
        String receiveKey = VideoManagerConstants.WVP_OTHER_RECEIVE_RTP_INFO + userSetting.getServerId() + "_*_"  + stream;
        List<Object> scan = RedisUtil.scan(redisTemplate, receiveKey);
        if (scan.size() > 0) {
            for (Object key : scan) {
                // 将信息写入redis中，以备后用
                redisTemplate.delete(key);
            }
        }
    }

    /**
     * 第三方服务对接->发送流
     *
     * @param ssrc 发送流的SSRC
     * @param dstIpForAudio 目标音频收流IP
     * @param dstIpForVideo 目标视频收流IP
     * @param dstPortForAudio 目标音频收流端口
     * @param dstPortForVideo 目标视频收流端口
     * @param app 待发送应用名
     * @param stream 待发送流Id
     * @param callId 整个过程的唯一标识，不传则使用随机端口发流
     * @param isUdp 是否为UDP
     * @param ptForAudio rtp的音频pt
     * @param ptForVideo rtp的视频pt
     */
    @GetMapping(value = "/send/start")
    @ResponseBody
    public void sendRTP(String ssrc,
                        @RequestParam(required = false)String dstIpForAudio,
                        @RequestParam(required = false)String dstIpForVideo,
                        @RequestParam(required = false)Integer dstPortForAudio,
                        @RequestParam(required = false)Integer dstPortForVideo,
                        String app,
                        String stream,
                        String callId,
                        Boolean isUdp,
                        @RequestParam(required = false)Integer ptForAudio,
                        @RequestParam(required = false)Integer ptForVideo
        ) {
        log.info("[第三方服务对接->发送流] " +
                        "ssrc->{}, \r\n" +
                        "dstIpForAudio->{}, \n" +
                        "dstIpForAudio->{}, \n" +
                        "dstPortForAudio->{},  \n" +
                        "dstPortForVideo->{}, \n" +
                        "app->{}, \n" +
                        "stream->{}, \n" +
                        "callId->{}, \n" +
                        "ptForAudio->{}, \n" +
                        "ptForVideo->{}",
                        ssrc,
                        dstIpForAudio,
                        dstIpForVideo,
                        dstPortForAudio,
                        dstPortForVideo,
                        app,
                        stream,
                        callId,
                        ptForAudio,
                        ptForVideo);
        if (!((dstPortForAudio > 0 && !ObjectUtils.isEmpty(dstPortForAudio) || (dstPortForVideo > 0 && !ObjectUtils.isEmpty(dstIpForVideo))))) {
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "至少应该存在一组音频或视频发送参数");
        }
        MediaServer mediaServer = mediaServerService.getDefaultMediaServer();
        String key = VideoManagerConstants.WVP_OTHER_SEND_RTP_INFO + userSetting.getServerId() + "_"  + callId;
        OtherRtpSendInfo sendInfo = (OtherRtpSendInfo)redisTemplate.opsForValue().get(key);
        if (sendInfo == null) {
            sendInfo = new OtherRtpSendInfo();
        }
        sendInfo.setPushApp(app);
        sendInfo.setPushStream(stream);
        sendInfo.setPushSSRC(ssrc);


        SendRtpInfo sendRtpItemForVideo;
        SendRtpInfo sendRtpItemForAudio;
        if (!ObjectUtils.isEmpty(dstIpForAudio) && dstPortForAudio > 0) {
            sendRtpItemForAudio = SendRtpInfo.getInstance(app, stream, ssrc, dstIpForAudio, dstPortForAudio, !isUdp, sendInfo.getSendLocalPortForAudio(), ptForAudio);
        } else {
            sendRtpItemForAudio = null;
        }
        if (!ObjectUtils.isEmpty(dstIpForVideo) && dstPortForVideo > 0) {
            sendRtpItemForVideo = SendRtpInfo.getInstance(app, stream, ssrc, dstIpForAudio, dstPortForAudio, !isUdp, sendInfo.getSendLocalPortForVideo(), ptForVideo);
        } else {
            sendRtpItemForVideo = null;
        }

        Boolean streamReady = mediaServerService.isStreamReady(mediaServer, app, stream);
        if (streamReady) {
            if (sendRtpItemForVideo != null) {
                mediaServerService.startSendRtp(mediaServer,  sendRtpItemForVideo);
                log.info("[第三方服务对接->发送流] 视频流发流成功，callId->{}，param->{}", callId, sendRtpItemForVideo);
                redisTemplate.opsForValue().set(key, sendInfo);
            }
            if(sendRtpItemForAudio != null) {
                mediaServerService.startSendRtp(mediaServer, sendRtpItemForAudio);
                log.info("[第三方服务对接->发送流] 音频流发流成功，callId->{}，param->{}", callId, sendRtpItemForAudio);
                redisTemplate.opsForValue().set(key, sendInfo);
            }
        }else {
            log.info("[第三方服务对接->发送流] 流不存在，等待流上线，callId->{}", callId);
            String uuid = UUID.randomUUID().toString();
            Hook hook = Hook.getInstance(HookType.on_media_arrival, app, stream, mediaServer.getId());
            dynamicTask.startDelay(uuid, ()->{
                log.info("[第三方服务对接->发送流] 等待流上线超时 callId->{}", callId);
                redisTemplate.delete(key);
                hookSubscribe.removeSubscribe(hook);
            }, 10000);

            // 订阅 zlm启动事件, 新的zlm也会从这里进入系统
            hookSubscribe.removeSubscribe(hook);
            OtherRtpSendInfo finalSendInfo = sendInfo;
            hookSubscribe.addSubscribe(hook,
                    (hookData)->{
                        dynamicTask.stop(uuid);
                        log.info("[第三方服务对接->发送流] 流上线，开始发流 callId->{}", callId);
                        try {
                            Thread.sleep(400);
                        } catch (InterruptedException e) {
                            throw new RuntimeException(e);
                        }
                        if (sendRtpItemForVideo != null) {
                            mediaServerService.startSendRtp(mediaServer, sendRtpItemForVideo);
                            log.info("[第三方服务对接->发送流] 视频流发流成功，callId->{}，param->{}", callId, sendRtpItemForVideo);
                            redisTemplate.opsForValue().set(key, finalSendInfo);
                        }
                        if(sendRtpItemForAudio != null) {
                            mediaServerService.startSendRtp(mediaServer, sendRtpItemForAudio);
                            log.info("[第三方服务对接->发送流] 音频流发流成功，callId->{}，param->{}", callId, sendRtpItemForAudio);
                            redisTemplate.opsForValue().set(key, finalSendInfo);
                        }
                        hookSubscribe.removeSubscribe(hook);
                    });
        }
    }

    /**
     * 第三方服务对接->关闭发送流
     *
     * @param callId 整个过程的唯一标识，不传则使用随机端口发流
     */
    @GetMapping(value = "/send/stop")
    @ResponseBody
    public void closeSendRTP(String callId) {
        log.info("[第三方服务对接->关闭发送流] callId->{}", callId);
        String key = VideoManagerConstants.WVP_OTHER_SEND_RTP_INFO + userSetting.getServerId() + "_"  + callId;
        OtherRtpSendInfo sendInfo = (OtherRtpSendInfo)redisTemplate.opsForValue().get(key);
        if (sendInfo == null){
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "未开启发流");
        }
        MediaServer mediaServerItem = mediaServerService.getDefaultMediaServer();
        mediaServerService.stopSendRtp(mediaServerItem, sendInfo.getPushApp(), sendInfo.getPushStream(), sendInfo.getPushSSRC());
        log.info("[第三方服务对接->关闭发送流] 成功 callId->{}", callId);
        redisTemplate.delete(key);
    }

}
