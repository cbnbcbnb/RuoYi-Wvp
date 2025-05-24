package com.ruoyi.wvp.vmanager.bean;


import com.ruoyi.wvp.gb28181.bean.GbStream;

import java.util.List;

/**
 * 多个推流信息
 *
 * @author lin
 */
public class BatchGBStreamParam {
    /**
     * 推流信息列表
     */
    private List<GbStream> gbStreams;

    public List<GbStream> getGbStreams() {
        return gbStreams;
    }

    public void setGbStreams(List<GbStream> gbStreams) {
        this.gbStreams = gbStreams;
    }
}
