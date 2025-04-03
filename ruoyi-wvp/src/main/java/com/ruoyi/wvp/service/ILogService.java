package com.ruoyi.wvp.service;

import com.ruoyi.wvp.service.bean.LogFileInfo;

import java.io.File;
import java.util.List;

public interface ILogService {
    List<LogFileInfo> queryList(String query, String startTime, String endTime);

    File getFileByName(String fileName);
}
