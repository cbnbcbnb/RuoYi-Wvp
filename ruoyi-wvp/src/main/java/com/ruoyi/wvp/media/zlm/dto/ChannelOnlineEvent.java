package com.ruoyi.wvp.media.zlm.dto;

import com.ruoyi.wvp.gb28181.bean.SendRtpInfo;

import java.text.ParseException;

/**
 * @author lin
 */
public interface ChannelOnlineEvent {

    void run(SendRtpInfo sendRtpItem) throws ParseException;
}
