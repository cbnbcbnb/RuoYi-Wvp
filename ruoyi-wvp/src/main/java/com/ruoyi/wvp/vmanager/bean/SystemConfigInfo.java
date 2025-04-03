package com.ruoyi.wvp.vmanager.bean;

import com.ruoyi.wvp.common.VersionPo;
import com.ruoyi.wvp.conf.SipConfig;
import com.ruoyi.wvp.conf.UserSetting;
import lombok.Data;

@Data
public class SystemConfigInfo {

    private int serverPort;
    private SipConfig sip;
    private UserSetting addOn;
    private VersionPo version;

}

