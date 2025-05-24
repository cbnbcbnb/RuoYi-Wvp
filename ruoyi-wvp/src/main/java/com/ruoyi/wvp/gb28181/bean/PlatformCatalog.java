package com.ruoyi.wvp.gb28181.bean;

/**
 * 国标级联-目录
 * @author lin
 */
public class PlatformCatalog {
    /**
     * ID
     */
    private String id;

    /**
     * 名称
     */
    private String name;

    /**
     * 平台ID
     */
    private String platformId;

    /**
     * 父级目录ID
     */
    private String parentId;

    /**
     * 行政区划
     */
    private String civilCode;

    /**
     * 目录分组
     */
    private String businessGroupId;

    /**
     * 子节点数
     */
    private int childrenCount;

    /**
     * 类型：0 目录, 1 国标通道, 2 直播流
     */
    private int type;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPlatformId() {
        return platformId;
    }

    public void setPlatformId(String platformId) {
        this.platformId = platformId;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public int getChildrenCount() {
        return childrenCount;
    }

    public void setChildrenCount(int childrenCount) {
        this.childrenCount = childrenCount;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setTypeForCatalog() {
        this.type = 0;
    }

    public void setTypeForGb() {
        this.type = 1;
    }

    public void setTypeForStream() {
        this.type = 2;
    }

    public String getCivilCode() {
        return civilCode;
    }

    public void setCivilCode(String civilCode) {
        this.civilCode = civilCode;
    }

    public String getBusinessGroupId() {
        return businessGroupId;
    }

    public void setBusinessGroupId(String businessGroupId) {
        this.businessGroupId = businessGroupId;
    }
}
