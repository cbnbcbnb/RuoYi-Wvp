package com.ruoyi.wvp.streamPush.bean;

import lombok.Data;

import java.util.Set;

@Data
public class BatchRemoveParam {
    private Set<Integer> ids;
}
