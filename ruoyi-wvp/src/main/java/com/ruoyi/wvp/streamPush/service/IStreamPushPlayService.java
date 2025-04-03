package com.ruoyi.wvp.streamPush.service;


import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.service.bean.ErrorCallback;

public interface IStreamPushPlayService {
    void start(Integer id, ErrorCallback<StreamInfo> callback, String platformDeviceId, String platformName );
}
