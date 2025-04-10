package com.ruoyi.onvif.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * onvif 设备对象 onvif_device
 *
 * @author 陈江灿
 * @date 2025-04-10
 */
@Data
public class OnvifDevice extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Long id;

    /**
     * ip
     */
    @Excel(name = "ip")
    private String ip;

    /** 摄像头名称 */
    @Excel(name = "摄像头名称")
    private String name;

    /**
     * 用户名
     */
    @Excel(name = "用户名")
    private String userName;

    /**
     * 密码
     */
    @Excel(name = "密码")
    private String password;

    /**
     * 默认直播流播放地址
     */
    @Excel(name = "默认直播流播放地址")
    private String url;

    /**
     * 设备厂商
     */
    @Excel(name = "设备厂商")
    private String firm;

    /**
     * 设备型号
     */
    @Excel(name = "设备型号")
    private String model;

    /**
     * 固件版本
     */
    @Excel(name = "固件版本")
    private String firmwareVersion;

    /**
     * 球机多条播放
     */
    @Excel(name = "球机多条播放")
    private Object streamUris;
}
