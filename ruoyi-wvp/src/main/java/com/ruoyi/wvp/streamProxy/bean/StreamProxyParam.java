package com.ruoyi.wvp.streamProxy.bean;

import lombok.Data;

/**
 * 拉流代理的信息
 * @author lin
 */
@Data
public class StreamProxyParam {

    /**
     * 类型，取值，default： 流媒体直接拉流（默认），ffmpeg： ffmpeg实现拉流
     */
    private String type;

    /**
     * 应用名
     */
    private String app;

    /**
     * 名称
     */
    private String name;

    /**
     * 流ID
     */
    private String stream;

    /**
     * 流媒体服务ID
     */
    private String mediaServerId;

    /**
     * 拉流地址
     */
    private String url;

    /**
     * 超时时间:秒
     */
    private int timeoutMs;

    /**
     * ffmpeg模板KEY
     */
    private String ffmpegCmdKey;

    /**
     * rtsp拉流时，拉流方式，0：tcp，1：udp，2：组播
     */
    private String rtpType;

    /**
     * 是否启用
     */
    private boolean enable;

    /**
     * 是否启用音频
     */
    private boolean enableAudio;

    /**
     * 是否启用MP4
     */
    private boolean enableMp4;

    /**
     * 是否 无人观看时删除
     */
    private boolean enableRemoveNoneReader;

    /**
     * 是否 无人观看时自动停用
     */
    private boolean enableDisableNoneReader;


    public StreamProxy buildStreamProxy() {
        StreamProxy streamProxy = new StreamProxy();
        streamProxy.setApp(app);
        streamProxy.setStream(stream);
        streamProxy.setRelatesMediaServerId(mediaServerId);
        streamProxy.setSrcUrl(url);
        streamProxy.setTimeout(timeoutMs/1000);
        streamProxy.setRtspType(rtpType);
        streamProxy.setEnable(enable);
        streamProxy.setEnableAudio(enableAudio);
        streamProxy.setEnableMp4(enableMp4);
        streamProxy.setEnableRemoveNoneReader(enableRemoveNoneReader);
        streamProxy.setEnableDisableNoneReader(enableDisableNoneReader);
        streamProxy.setFfmpegCmdKey(ffmpegCmdKey);
        streamProxy.setGbName(name);
        return streamProxy;

    }
}
