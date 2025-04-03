package com.ruoyi.wvp.service;


import com.ruoyi.wvp.gb28181.bean.MobilePosition;
import com.ruoyi.wvp.gb28181.bean.Platform;
import com.ruoyi.wvp.service.bean.GPSMsgInfo;

import java.util.List;

public interface IMobilePositionService {

    void add(List<MobilePosition> mobilePositionList);

    void add(MobilePosition mobilePosition);

    List<MobilePosition> queryMobilePositions(String deviceId, String channelId, String startTime, String endTime);

    List<Platform> queryEnablePlatformListWithAsMessageChannel();

    MobilePosition queryLatestPosition(String deviceId);

    void updateStreamGPS(List<GPSMsgInfo> gpsMsgInfoList);

}
