package com.ruoyi.wvp.gb28181.bean;

/**
 * 平台国标流
 */
public class PlatformGbStream {

    /**
     * ID
     */
    private int gbStreamId;

    /**
     * 平台ID
     */
    private String platformId;

    /**
     * 目录ID
     */
    private String catalogId;

    public Integer getGbStreamId() {
        return gbStreamId;
    }

    public void setGbStreamId(Integer gbStreamId) {
        this.gbStreamId = gbStreamId;
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
