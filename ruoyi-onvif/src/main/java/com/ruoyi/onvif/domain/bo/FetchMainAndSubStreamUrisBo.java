package com.ruoyi.onvif.domain.bo;

import lombok.Data;

/**
 * 获取onvif设备信息 BO
 * @Author: 陈江灿
 * @CreateTime: 2025-04-09
 */
@Data
public class FetchMainAndSubStreamUrisBo {

    private String ip;

    private String username;

    private String password;
}
