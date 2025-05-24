package com.ruoyi.wvp.controller;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.media.zlm.dto.StreamAuthorityInfo;
import com.ruoyi.wvp.storager.IRedisCatchStorage;
import com.ruoyi.wvp.streamProxy.service.IStreamProxyService;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.StreamContent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;


/**
 * 媒体流相关
 */
@RestController
@Slf4j
@RequestMapping(value = "/api/media")
public class MediaController {

    @Autowired
    private IRedisCatchStorage redisCatchStorage;

    @Autowired
    private IStreamProxyService streamProxyService;

    @Autowired
    private IMediaServerService mediaServerService;


    /**
     * 根据应用名和流id获取播放地址
     *
     * @param request
     * @param app 应用名
     * @param stream 流id
     * @param mediaServerId 媒体服务器id
     * @param callId 推流时携带的自定义鉴权ID
     * @param useSourceIpAsStreamIp 是否使用请求IP作为返回的地址IP
     * @return
     */
    @GetMapping(value = "/stream_info_by_app_and_stream")
    @ResponseBody
    public StreamContent getStreamInfoByAppAndStream(HttpServletRequest request, @RequestParam String app,
                                                     @RequestParam String stream,
                                                     @RequestParam(required = false) String mediaServerId,
                                                     @RequestParam(required = false) String callId,
                                                     @RequestParam(required = false) Boolean useSourceIpAsStreamIp){
        boolean authority = false;
        if (callId != null) {
            // 权限校验
            StreamAuthorityInfo streamAuthorityInfo = redisCatchStorage.getStreamAuthorityInfo(app, stream);
            if (streamAuthorityInfo != null
                    && streamAuthorityInfo.getCallId() != null
                    && streamAuthorityInfo.getCallId().equals(callId)) {
                authority = true;
            }else {
                throw new ControllerException(ErrorCode.ERROR400.getCode(), "获取播放地址鉴权失败");
            }
        }else {
            // 是否登陆用户, 登陆用户返回完整信息
            LoginUser userInfo = SecurityUtils.getLoginUser();
            if (userInfo!= null) {
                authority = true;
            }
        }

        StreamInfo streamInfo;

        if (useSourceIpAsStreamIp != null && useSourceIpAsStreamIp) {
            String host = request.getHeader("Host");
            String localAddr = host.split(":")[0];
            log.info("使用{}作为返回流的ip", localAddr);
            streamInfo = mediaServerService.getStreamInfoByAppAndStreamWithCheck(app, stream, mediaServerId, localAddr, authority);
        }else {
            streamInfo = mediaServerService.getStreamInfoByAppAndStreamWithCheck(app, stream, mediaServerId, authority);
        }

        if (streamInfo != null){
            return  new StreamContent(streamInfo);
        }else {
            //获取流失败，重启拉流后重试一次
            streamProxyService.stopByAppAndStream(app,stream);
            boolean start = streamProxyService.startByAppAndStream(app, stream);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                log.error("[线程休眠失败]， {}", e.getMessage());
            }
            if (useSourceIpAsStreamIp != null && useSourceIpAsStreamIp) {
                String host = request.getHeader("Host");
                String localAddr = host.split(":")[0];
                log.info("使用{}作为返回流的ip", localAddr);
                streamInfo = mediaServerService.getStreamInfoByAppAndStreamWithCheck(app, stream, mediaServerId, localAddr, authority);
            }else {
                streamInfo = mediaServerService.getStreamInfoByAppAndStreamWithCheck(app, stream, mediaServerId, authority);
            }
            if (streamInfo != null){
                return new StreamContent(streamInfo);
            }else {
                throw new ControllerException(ErrorCode.ERROR100);
            }
        }
    }
    /**
     * 获取推流播放地址
     * @param app 应用名
     * @param stream 流id
     * @param mediaServerId 媒体服务器id
     * @return
     */
    @GetMapping(value = "/getPlayUrl")
    @ResponseBody
    public StreamContent getPlayUrl(@RequestParam String app, @RequestParam String stream,
                                    @RequestParam(required = false) String mediaServerId){
        boolean authority = false;
        // 是否登陆用户, 登陆用户返回完整信息
        LoginUser userInfo = SecurityUtils.getLoginUser();
        if (userInfo!= null) {
            authority = true;
        }
        StreamInfo streamInfo = mediaServerService.getStreamInfoByAppAndStreamWithCheck(app, stream, mediaServerId, authority);
        if (streamInfo == null){
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "获取播放地址失败");
        }
        return new StreamContent(streamInfo);
    }
}
