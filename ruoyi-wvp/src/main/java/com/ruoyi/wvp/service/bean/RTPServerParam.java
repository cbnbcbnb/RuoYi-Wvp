package com.ruoyi.wvp.service.bean;

import com.ruoyi.wvp.media.bean.MediaServer;
import lombok.Data;

@Data
public class RTPServerParam {

    private MediaServer mediaServerItem;
    private String streamId;
    private String presetSsrc;
    private boolean ssrcCheck;
    private boolean playback;
    private Integer port;
    private boolean onlyAuto;
    private boolean disableAudio;
    private boolean reUsePort;

    /**
     * tcp模式，0时为不启用tcp监听，1时为启用tcp监听，2时为tcp主动连接模式
     */
    private Integer tcpMode;


}
