package com.ruoyi.wvp.streamPush.bean;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

@Data
public class StreamPushExcelDto {

    /**
     * 名称
     */
    @ExcelProperty("名称")
    private String name;

    /**
     * 应用名
     */
    @ExcelProperty("应用名")
    private String app;

    /**
     * 流ID
     */
    @ExcelProperty("流ID")
    private String stream;

    /**
     * 国标ID
     */
    @ExcelProperty("国标ID")
    private String gbDeviceId;

    /**
     * 在线状态
     */
    @ExcelProperty("在线状态")
    private boolean status;

    /**
     * 经度 WGS-84坐标系
     */
    private Double longitude;

    /**
     * 纬度 WGS-84坐标系
     */
    private Double latitude;
}
