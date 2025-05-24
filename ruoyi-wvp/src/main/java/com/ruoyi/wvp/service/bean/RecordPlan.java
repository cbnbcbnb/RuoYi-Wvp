package com.ruoyi.wvp.service.bean;

import lombok.Data;

import java.util.List;

/**
 * 录制计划
 */
@Data
public class RecordPlan {

    /**
     * 计划数据库ID
     */
    private int id;

    /**
     * 计划名称
     */
    private String name;

    /**
     * 计划关联通道数量
     */
    private int channelCount;

    /**
     * 是否开启定时截图
     */
    private Boolean snap;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 计划内容
     */
    private List<RecordPlanItem> planItemList;
}
