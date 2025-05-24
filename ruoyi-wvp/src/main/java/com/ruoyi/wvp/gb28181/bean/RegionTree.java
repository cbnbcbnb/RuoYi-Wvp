package com.ruoyi.wvp.gb28181.bean;

import lombok.Data;

/**
 * 区域
 */
@Data
public class RegionTree extends Region {

    /**
     * 树节点ID
     */
    private String treeId;

    /**
     * 是否有子节点
     */
    private boolean isLeaf;

    /**
     * 类型, 行政区划:0 摄像头: 1
     */
    private int type;

    /**
     * 在线状态
     */
    private String status;
}
