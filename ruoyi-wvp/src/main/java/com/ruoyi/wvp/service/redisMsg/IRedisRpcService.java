package com.ruoyi.wvp.service.redisMsg;

import com.ruoyi.wvp.common.CommonCallback;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.gb28181.bean.SendRtpInfo;
import com.ruoyi.wvp.vmanager.bean.WVPResult;

public interface IRedisRpcService {

    SendRtpInfo getSendRtpItem(String callId);

    WVPResult startSendRtp(String callId, SendRtpInfo sendRtpItem);

    WVPResult stopSendRtp(String callId);

    long waitePushStreamOnline(SendRtpInfo sendRtpItem, CommonCallback<Integer> callback);

    void stopWaitePushStreamOnline(SendRtpInfo sendRtpItem);

    void rtpSendStopped(String callId);

    void removeCallback(long key);

    long onStreamOnlineEvent(String app, String stream, CommonCallback<StreamInfo> callback);
    void unPushStreamOnlineEvent(String app, String stream);
}
