package com.ruoyi.wvp.gb28181.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 音频切换
 * @author fengcheng
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChangeAudio {

    /**
     * 通道的数据库ID
     */
    private Integer channelId;

    /**
     * 开启/关闭音频
     */
    private Boolean audio;
}
