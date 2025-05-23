package com.ruoyi.wvp.service.impl;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.dynamic.datasource.annotation.DS;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.service.ICloudRecordService;
import com.ruoyi.wvp.mapper.CloudRecordServiceMapper;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.event.media.MediaRecordMp4Event;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.media.zlm.AssistRESTfulUtils;
import com.ruoyi.wvp.media.zlm.dto.StreamAuthorityInfo;
import com.ruoyi.wvp.service.bean.CloudRecordItem;
import com.ruoyi.wvp.service.bean.DownloadFileInfo;
import com.ruoyi.wvp.storager.IRedisCatchStorage;
import com.ruoyi.wvp.utils.CloudRecordUtils;
import com.ruoyi.wvp.utils.DateUtil;
import com.ruoyi.common.enums.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
@DS("share")
public class CloudRecordServiceImpl implements ICloudRecordService {

    @Autowired
    private CloudRecordServiceMapper cloudRecordServiceMapper;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private IRedisCatchStorage redisCatchStorage;

    @Autowired
    private AssistRESTfulUtils assistRESTfulUtils;

    @Override
    public List<CloudRecordItem> getList(int pageNum, int pageSize, String query, String app, String stream, String startTime, String endTime, List<MediaServer> mediaServerItems, String callId) {
        // 开始时间和结束时间在数据库中都是以秒为单位的
        Long startTimeStamp = null;
        Long endTimeStamp = null;
        if (startTime != null) {
            if (!DateUtil.verification(startTime, DateUtil.formatter)) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "开始时间格式错误，正确格式为： " + DateUtil.formatter);
            }
            startTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestampMs(startTime);

        }
        if (endTime != null) {
            if (!DateUtil.verification(endTime, DateUtil.formatter)) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "结束时间格式错误，正确格式为： " + DateUtil.formatter);
            }
            endTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestampMs(endTime);

        }
        if (query != null) {
            query = query.replaceAll("/", "//")
                    .replaceAll("%", "/%")
                    .replaceAll("_", "/_");
        }
        return cloudRecordServiceMapper.getList(query, app, stream, startTimeStamp, endTimeStamp,
                callId, mediaServerItems, null);
    }

    @Override
    public List<String> getDateList(String app, String stream, int year, int month, List<MediaServer> mediaServerItems) {
        LocalDate startDate = LocalDate.of(year, month, 1);
        LocalDate endDate;
        if (month == 12) {
            endDate = LocalDate.of(year + 1, 1, 1);
        } else {
            endDate = LocalDate.of(year, month + 1, 1);
        }
        long startTimeStamp = startDate.atStartOfDay().toInstant(ZoneOffset.ofHours(8)).toEpochMilli();
        long endTimeStamp = endDate.atStartOfDay().toInstant(ZoneOffset.ofHours(8)).toEpochMilli();
        List<CloudRecordItem> cloudRecordItemList = cloudRecordServiceMapper.getList(null, app, stream, startTimeStamp,
                endTimeStamp, null, mediaServerItems, null);
        if (cloudRecordItemList.isEmpty()) {
            return new ArrayList<>();
        }
        Set<String> resultSet = new HashSet<>();
        cloudRecordItemList.stream().forEach(cloudRecordItem -> {
            String date = DateUtil.timestampTo_yyyy_MM_dd(cloudRecordItem.getStartTime());
            resultSet.add(date);
        });
        return new ArrayList<>(resultSet);
    }

    @Async("taskExecutor")
    @EventListener
    public void onApplicationEvent(MediaRecordMp4Event event) {
        CloudRecordItem cloudRecordItem = CloudRecordItem.getInstance(event);
        if (ObjectUtils.isEmpty(cloudRecordItem.getCallId())) {
            StreamAuthorityInfo streamAuthorityInfo = redisCatchStorage.getStreamAuthorityInfo(event.getApp(), event.getStream());
            if (streamAuthorityInfo != null) {
                cloudRecordItem.setCallId(streamAuthorityInfo.getCallId());
            }
        }
        log.info("[添加录像记录] {}/{}, callId: {}, 内容：{}", event.getApp(), event.getStream(), cloudRecordItem.getCallId(), event.getRecordInfo());
        cloudRecordServiceMapper.add(cloudRecordItem);
    }

    @Override
    public String addTask(String app, String stream, MediaServer mediaServerItem, String startTime, String endTime,
                          String callId, String remoteHost, boolean filterMediaServer) {
        // 参数校验
        Assert.notNull(app, "应用名为NULL");
        Assert.notNull(stream, "流ID为NULL");
        if (mediaServerItem.getRecordAssistPort() == 0) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "为配置Assist服务");
        }
        Long startTimeStamp = null;
        Long endTimeStamp = null;
        if (startTime != null) {
            startTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestamp(startTime);
        }
        if (endTime != null) {
            endTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestamp(endTime);
        }

        List<MediaServer> mediaServers = new ArrayList<>();
        mediaServers.add(mediaServerItem);
        // 检索相关的录像文件
        List<String> filePathList = cloudRecordServiceMapper.queryRecordFilePathList(app, stream, startTimeStamp,
                endTimeStamp, callId, filterMediaServer ? mediaServers : null);
        if (filePathList == null || filePathList.isEmpty()) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "未检索到视频文件");
        }
        JSONObject result = assistRESTfulUtils.addTask(mediaServerItem, app, stream, startTime, endTime, callId, filePathList, remoteHost);
        if (result.getInteger("code") != 0) {
            throw new ControllerException(result.getInteger("code"), result.getString("msg"));
        }
        return result.getString("data");
    }

    @Override
    public JSONArray queryTask(String app, String stream, String callId, String taskId, String mediaServerId,
                               Boolean isEnd, String scheme) {
        MediaServer mediaServerItem = null;
        if (mediaServerId == null) {
            mediaServerItem = mediaServerService.getDefaultMediaServer();
        } else {
            mediaServerItem = mediaServerService.getOne(mediaServerId);
        }
        if (mediaServerItem == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到可用的流媒体");
        }

        JSONObject result = assistRESTfulUtils.queryTaskList(mediaServerItem, app, stream, callId, taskId, isEnd, scheme);
        if (result == null || result.getInteger("code") != 0) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), result == null ? "查询任务列表失败" : result.getString("msg"));
        }
        return result.getJSONArray("data");
    }

    @Override
    public int changeCollect(boolean result, String app, String stream, String mediaServerId, String startTime, String endTime, String callId) {
        // 开始时间和结束时间在数据库中都是以秒为单位的
        Long startTimeStamp = null;
        Long endTimeStamp = null;
        if (startTime != null) {
            if (!DateUtil.verification(startTime, DateUtil.formatter)) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "开始时间格式错误，正确格式为： " + DateUtil.formatter);
            }
            startTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestamp(startTime);

        }
        if (endTime != null) {
            if (!DateUtil.verification(endTime, DateUtil.formatter)) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "结束时间格式错误，正确格式为： " + DateUtil.formatter);
            }
            endTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestamp(endTime);

        }

        List<MediaServer> mediaServerItems;
        if (!ObjectUtils.isEmpty(mediaServerId)) {
            mediaServerItems = new ArrayList<>();
            MediaServer mediaServerItem = mediaServerService.getOne(mediaServerId);
            if (mediaServerItem == null) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到流媒体: " + mediaServerId);
            }
            mediaServerItems.add(mediaServerItem);
        } else {
            mediaServerItems = null;
        }

        List<CloudRecordItem> all = cloudRecordServiceMapper.getList(null, app, stream, startTimeStamp, endTimeStamp,
                callId, mediaServerItems, null);
        if (all.isEmpty()) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到待收藏的视频");
        }
        int limitCount = 50;
        int resultCount = 0;
        if (all.size() > limitCount) {
            for (int i = 0; i < all.size(); i += limitCount) {
                int toIndex = i + limitCount;
                if (i + limitCount > all.size()) {
                    toIndex = all.size();
                }
                resultCount += cloudRecordServiceMapper.updateCollectList(result, all.subList(i, toIndex));

            }
        } else {
            resultCount = cloudRecordServiceMapper.updateCollectList(result, all);
        }
        return resultCount;
    }

    @Override
    public int changeCollectById(Integer recordId, boolean result) {
        return cloudRecordServiceMapper.changeCollectById(result, recordId);
    }

    @Override
    public DownloadFileInfo getPlayUrlPath(Integer recordId) {
        CloudRecordItem recordItem = cloudRecordServiceMapper.queryOne(recordId);
        if (recordItem == null) {
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "资源不存在");
        }
        String filePath = recordItem.getFilePath();
        MediaServer mediaServerItem = mediaServerService.getOne(recordItem.getMediaServerId());
        return CloudRecordUtils.getDownloadFilePath(mediaServerItem, filePath);
    }

    @Override
    public List<CloudRecordItem> getAllList(String query, String app, String stream, String startTime, String endTime, List<MediaServer> mediaServerItems, String callId, List<Integer> ids) {
        // 开始时间和结束时间在数据库中都是以秒为单位的
        Long startTimeStamp = null;
        Long endTimeStamp = null;
        if (startTime != null) {
            if (!DateUtil.verification(startTime, DateUtil.formatter)) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "开始时间格式错误，正确格式为： " + DateUtil.formatter);
            }
            startTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestampMs(startTime);

        }
        if (endTime != null) {
            if (!DateUtil.verification(endTime, DateUtil.formatter)) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "结束时间格式错误，正确格式为： " + DateUtil.formatter);
            }
            endTimeStamp = DateUtil.yyyy_MM_dd_HH_mm_ssToTimestampMs(endTime);

        }
        return cloudRecordServiceMapper.getList(query, app, stream, startTimeStamp, endTimeStamp,
                callId, mediaServerItems, ids);
    }
}
