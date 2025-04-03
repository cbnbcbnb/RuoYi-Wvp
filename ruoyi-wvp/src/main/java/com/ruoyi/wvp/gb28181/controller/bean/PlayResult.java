package com.ruoyi.wvp.gb28181.controller.bean;

import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.vmanager.bean.WVPResult;
import org.springframework.web.context.request.async.DeferredResult;

public class PlayResult {

    private DeferredResult<WVPResult<StreamInfo>> result;
    private String uuid;

    private Device device;

    public DeferredResult<WVPResult<StreamInfo>> getResult() {
        return result;
    }

    public void setResult(DeferredResult<WVPResult<StreamInfo>> result) {
        this.result = result;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Device getDevice() {
        return device;
    }

    public void setDevice(Device device) {
        this.device = device;
    }
}
