package com.ruoyi.wvp.service.bean;

import lombok.Data;

/**
 * 录制计划项
 */
@Data
public class RecordPlanItem {

    /**
     * 计划项数据库ID
     */
    private int id;

    /**
     * 计划开始时间的序号， 从0点开始，每半个小时增加1
     */
    private Integer start;

    /**
     * 计划结束时间的序号， 从0点开始，每半个小时增加1
     */
    private Integer stop;

    /**
     * 计划周几执行
     */
    private Integer weekDay;

    /**
     * 所属计划ID
     */
    private Integer planId;

}
