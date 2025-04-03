package com.ruoyi.wvp.gb28181.service;


import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.gb28181.bean.CommonGBChannel;
import com.ruoyi.wvp.gb28181.bean.InviteInfo;
import com.ruoyi.wvp.gb28181.bean.Platform;
import com.ruoyi.wvp.service.bean.ErrorCallback;

public interface IGbChannelPlayService {

    void start(CommonGBChannel channel, InviteInfo inviteInfo, Platform platform, ErrorCallback<StreamInfo> callback);

    void play(CommonGBChannel channel, Platform platform, Boolean record, ErrorCallback<StreamInfo> callback);

    void playGbDeviceChannel(CommonGBChannel channel, Boolean record, ErrorCallback<StreamInfo> callback);

    void playProxy(CommonGBChannel channel, Boolean record, ErrorCallback<StreamInfo> callback);

    void playPush(CommonGBChannel channel, String platformDeviceId, String platformName, ErrorCallback<StreamInfo> callback);
}
