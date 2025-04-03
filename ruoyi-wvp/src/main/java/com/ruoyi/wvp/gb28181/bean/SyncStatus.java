package com.ruoyi.wvp.gb28181.bean;


import lombok.Data;

import java.time.Instant;

/**
 * 摄像机同步状态
 * @author lin
 */
@Data
public class SyncStatus {

    /**
     * 总数
     */
    private Integer total;

    /**
     * 当前更新多少
     */
    private Integer current;

    /**
     * 错误描述
     */
    private String errorMsg;

    /**
     * 是否同步中
     */
    private Boolean syncIng;

    /**
     * 时间
     */
    private Instant time;


}
