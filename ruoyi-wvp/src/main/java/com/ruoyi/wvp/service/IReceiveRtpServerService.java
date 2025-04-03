package com.ruoyi.wvp.service;

import com.ruoyi.wvp.gb28181.bean.OpenRTPServerResult;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.service.bean.ErrorCallback;
import com.ruoyi.wvp.service.bean.RTPServerParam;
import com.ruoyi.wvp.service.bean.SSRCInfo;

public interface IReceiveRtpServerService {
    SSRCInfo openRTPServer(RTPServerParam rtpServerParam, ErrorCallback<OpenRTPServerResult> callback);

    void closeRTPServer(MediaServer mediaServer, SSRCInfo ssrcInfo);
}
