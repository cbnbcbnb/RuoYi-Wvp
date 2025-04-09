package com.ruoyi.onvif.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 获取主副流uri 实体类
 * @Author: 陈江灿
 * @CreateTime: 2025-04-09
 */
@Data
public class FetchMainAndSubStreamUris extends BaseEntity {

    /** 主键 */
    private Long id;

    /**
     * 设备ip
     */
    private String ip;

    /**
     * 设备厂商
     */
    private String firm;

    /**
     * 设备型号
     */
    private String model;

    /**
     * 固件版本
     */
    private String firmwareVersion;

    /**
     * 球机多条播放
     */
    private Map<String, String> streamUris = new ConcurrentHashMap<>();

    public void addStreamUri(String profileName, String mediaUri) {
        this.streamUris.put(profileName, mediaUri);
    }
}
