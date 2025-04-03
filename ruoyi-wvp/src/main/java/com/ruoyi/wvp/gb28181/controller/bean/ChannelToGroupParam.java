package com.ruoyi.wvp.gb28181.controller.bean;

import lombok.Data;

import java.util.List;

@Data
public class ChannelToGroupParam {

    private String parentId;
    private String businessGroup;
    private List<Integer> channelIds;

}
