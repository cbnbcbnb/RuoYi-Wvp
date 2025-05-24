package com.ruoyi.wvp.gb28181.controller.bean;

import lombok.Data;

import java.util.List;

/**
 * 通道关联参数
 */
@Data
public class UpdateChannelParam {

    /**
     * 上级平台的数据库ID
     */
    private Integer platformId;


    /**
     * 关联所有通道
     */
    private boolean all;

    /**
     * 待关联的通道ID
     */
    List<Integer> channelIds;

    /**
     * 待关联的设备ID
     */
    List<Integer> deviceIds;
}
