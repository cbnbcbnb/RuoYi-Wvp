package com.ruoyi.wvp.streamProxy.service;

import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.service.bean.ErrorCallback;
import com.ruoyi.wvp.streamProxy.bean.StreamProxy;

public interface IStreamProxyPlayService {

    StreamInfo start(int id, Boolean record, ErrorCallback<StreamInfo> callback);

    void start(int id, ErrorCallback<StreamInfo> callback);

    StreamInfo startProxy(StreamProxy streamProxy);

    void stop(int id);

    void stopProxy(StreamProxy streamProxy);
}
