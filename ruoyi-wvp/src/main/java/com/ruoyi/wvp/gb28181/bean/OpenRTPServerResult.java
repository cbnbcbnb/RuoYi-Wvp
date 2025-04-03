package com.ruoyi.wvp.gb28181.bean;

import com.ruoyi.wvp.media.event.hook.HookData;
import com.ruoyi.wvp.service.bean.SSRCInfo;
import lombok.Data;

@Data
public class OpenRTPServerResult {

    private SSRCInfo ssrcInfo;
    private HookData hookData;
}
