package com.ruoyi.wvp.gb28181.controller.bean;


/**
 * 精简的channel信息展示，主要是选择通道的时候展示列表使用
 */
public class ChannelReduce {

    /**
     * deviceChannel的数据库自增ID
     */
    private int id;

    /**
     * 通道国标编号
     */
    private String channelId;

    /**
     * 设备国标编号
     */
    private String deviceId;

    /**
     * 通道名
     */
    private String name;

    /**
     * 生产厂商
     */
    private String manufacturer;

    /**
     * wan地址
     */
    private String hostAddress;

    /**
     * 子节点数
     */
    private int subCount;

    /**
     * 平台上级国标编号
     */
    private String platformId;

    /**
     * 目录国标编号
     */
    private String catalogId;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getHostAddress() {
        return hostAddress;
    }

    public void setHostAddress(String hostAddress) {
        this.hostAddress = hostAddress;
    }

    public int getSubCount() {
        return subCount;
    }

    public void setSubCount(int subCount) {
        this.subCount = subCount;
    }

    public String getPlatformId() {
        return platformId;
    }

    public void setPlatformId(String platformId) {
        this.platformId = platformId;
    }

    public String getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(String catalogId) {
        this.catalogId = catalogId;
    }
}
