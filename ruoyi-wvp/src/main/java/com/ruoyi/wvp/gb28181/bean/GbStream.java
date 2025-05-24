package com.ruoyi.wvp.gb28181.bean;

/**
 * 直播流关联国标上级平台
 * @author lin
 */
public class GbStream extends PlatformGbStream{

    /**
     * ID
     */
    private int gbStreamId;

    /**
     * 应用名
     */
    private String app;

    /**
     * 流ID
     */
    private String stream;

    /**
     * 国标ID
     */
    private String gbId;

    /**
     * 名称
     */
    private String name;

    /**
     * 流媒体ID
     */
    private String mediaServerId;

    /**
     * 经度
     */
    private double longitude;

    /**
     * 纬度
     */
    private double latitude;

    /**
     * 流类型（拉流/推流）
     */
    private String streamType;

    /**
     * 状态
     */
    private boolean status;

    /**
     * 创建时间
     */
    public String createTime;

    @Override
    public Integer getGbStreamId() {
        return gbStreamId;
    }

    @Override
    public void setGbStreamId(Integer gbStreamId) {
        this.gbStreamId = gbStreamId;
    }

    public String getApp() {
        return app;
    }

    public void setApp(String app) {
        this.app = app;
    }

    public String getStream() {
        return stream;
    }

    public void setStream(String stream) {
        this.stream = stream;
    }

    public String getGbId() {
        return gbId;
    }

    public void setGbId(String gbId) {
        this.gbId = gbId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public String getStreamType() {
        return streamType;
    }

    public void setStreamType(String streamType) {
        this.streamType = streamType;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getMediaServerId() {
        return mediaServerId;
    }

    public void setMediaServerId(String mediaServerId) {
        this.mediaServerId = mediaServerId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
