package com.ruoyi.system.domain;

/**
 * 工作台
 *
 * @author fengcheng
 */
public class SysWork {
    /**
     *
     */
    private String layoutList;

    /**
     * 索引
     */
    private String index;

    public String getLayoutList() {
        return layoutList;
    }

    public void setLayoutList(String layoutList) {
        this.layoutList = layoutList;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    @Override
    public String toString() {
        return "SysWork{" +
                "layoutList='" + layoutList + '\'' +
                ", index='" + index + '\'' +
                '}';
    }
}
