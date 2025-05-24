package com.ruoyi.wvp.controller;

import com.alibaba.fastjson2.JSONArray;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.service.ICloudRecordService;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.service.bean.CloudRecordItem;
import com.ruoyi.wvp.utils.DateUtil;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.cloudRecord.bean.CloudRecordUrl;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 云端录像Controller
 */
@SuppressWarnings("rawtypes")
@Slf4j
@RestController
@RequestMapping("/api/cloud/record")
public class CloudRecordController extends BaseController {


    @Autowired
    private ICloudRecordService cloudRecordService;

    @Autowired
    private IMediaServerService mediaServerService;

    /**
     * 查询云端录像
     *
     * @param app           应用名
     * @param stream        流ID
     * @param year          年，置空则查询当年
     * @param month         月，置空则查询当月
     * @param mediaServerId 流媒体ID，置空则查询全部
     * @return
     */
    @ResponseBody
    @GetMapping("/date/list")
    public AjaxResult openRtpServer(@RequestParam(required = true) String app, @RequestParam(required = true) String stream, @RequestParam(required = false) Integer year, @RequestParam(required = false) Integer month, @RequestParam(required = false) String mediaServerId

    ) {
        log.info("[云端录像] 查询存在云端录像的日期 app->{}, stream->{}, mediaServerId->{}, year->{}, month->{}", app, stream, mediaServerId, year, month);
        Calendar calendar = Calendar.getInstance();
        if (ObjectUtils.isEmpty(year)) {
            year = calendar.get(Calendar.YEAR);
        }
        if (ObjectUtils.isEmpty(month)) {
            month = calendar.get(Calendar.MONTH) + 1;
        }
        List<MediaServer> mediaServers;
        if (!ObjectUtils.isEmpty(mediaServerId)) {
            mediaServers = new ArrayList<>();
            MediaServer mediaServer = mediaServerService.getOne(mediaServerId);
            if (mediaServer == null) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到流媒体: " + mediaServerId);
            }
            mediaServers.add(mediaServer);
        } else {
            mediaServers = mediaServerService.getAllOnlineList();
        }
        if (mediaServers.isEmpty()) {
            return success(new ArrayList<>());
        }

        return success(cloudRecordService.getDateList(app, stream, year, month, mediaServers));
    }

    /**
     * 查询云端录像
     *
     * @param query         检索内容
     * @param app           应用名
     * @param stream        流ID
     * @param pageNum       当前页
     * @param pageSize      每页查询数量
     * @param startTime     开始时间(yyyy-MM-dd HH:mm:ss)
     * @param endTime       结束时间(yyyy-MM-dd HH:mm:ss)
     * @param mediaServerId 流媒体ID，置空则查询全部流媒体
     * @param callId        每次录像的唯一标识，置空则查询全部流媒体
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:record:list')")
    @ResponseBody
    @GetMapping("/list")
    public TableDataInfo openRtpServer(
            @RequestParam(required = false) String query,
            @RequestParam(required = false) String app,
            @RequestParam(required = false) String stream,
            @RequestParam int pageNum,
            @RequestParam int pageSize,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            @RequestParam(required = false) String mediaServerId,
            @RequestParam(required = false) String callId

    ) {
        log.info("[云端录像] 查询 app->{}, stream->{}, mediaServerId->{}, pageNum->{}, pageSize->{}, startTime->{}, endTime->{}, callId->{}",
                app, stream, mediaServerId, pageNum, pageSize, startTime, endTime, callId);
        List<MediaServer> mediaServers;
        if (!ObjectUtils.isEmpty(mediaServerId)) {
            mediaServers = new ArrayList<>();
            MediaServer mediaServer = mediaServerService.getOne(mediaServerId);
            if (mediaServer == null) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到流媒体: " + mediaServerId);
            }
            mediaServers.add(mediaServer);
        } else {
            mediaServers = mediaServerService.getAllOnlineList();
        }
        if (mediaServers.isEmpty()) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "当前无流媒体");
        }
        if (query != null && ObjectUtils.isEmpty(query.trim())) {
            query = null;
        }
        if (app != null && ObjectUtils.isEmpty(app.trim())) {
            app = null;
        }
        if (stream != null && ObjectUtils.isEmpty(stream.trim())) {
            stream = null;
        }
        if (startTime != null && ObjectUtils.isEmpty(startTime.trim())) {
            startTime = null;
        }
        if (endTime != null && ObjectUtils.isEmpty(endTime.trim())) {
            endTime = null;
        }
        if (callId != null && ObjectUtils.isEmpty(callId.trim())) {
            callId = null;
        }
        startPage();
        List<CloudRecordItem> list = cloudRecordService.getList(pageNum, pageSize, query, app, stream, startTime, endTime, mediaServers, callId);
        return getDataTable(list);
    }

    /**
     * 添加合并任务
     *
     * @param request
     * @param app 应用名
     * @param stream 流ID
     * @param mediaServerId 流媒体ID
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @param callId 鉴权ID
     * @param remoteHost 返回地址时的远程地址
     * @return
     */
    @ResponseBody
    @GetMapping("/task/add")
    public String addTask(HttpServletRequest request, @RequestParam(required = false) String app, @RequestParam(required = false) String stream, @RequestParam(required = false) String mediaServerId, @RequestParam(required = false) String startTime, @RequestParam(required = false) String endTime, @RequestParam(required = false) String callId, @RequestParam(required = false) String remoteHost) {
        MediaServer mediaServer;
        if (mediaServerId == null) {
            mediaServer = mediaServerService.getDefaultMediaServer();
        } else {
            mediaServer = mediaServerService.getOne(mediaServerId);
        }
        if (mediaServer == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到可用的流媒体");
        } else {
            if (remoteHost == null) {
                remoteHost = request.getScheme() + "://" + mediaServer.getIp() + ":" + mediaServer.getRecordAssistPort();
            }
        }
        return cloudRecordService.addTask(app, stream, mediaServer, startTime, endTime, callId, remoteHost, mediaServerId != null);
    }

    /**
     * 查询合并任务
     *
     * @param request
     * @param app
     * @param stream
     * @param callId
     * @param taskId 任务Id
     * @param mediaServerId 流媒体ID
     * @param isEnd 是否结束
     * @return
     */
    @ResponseBody
    @GetMapping("/task/list")
    public JSONArray queryTaskList(HttpServletRequest request, @RequestParam(required = false) String app, @RequestParam(required = false) String stream, @RequestParam(required = false) String callId, @RequestParam(required = false) String taskId, @RequestParam(required = false) String mediaServerId, @RequestParam(required = false) Boolean isEnd) {
        if (ObjectUtils.isEmpty(mediaServerId)) {
            mediaServerId = null;
        }

        return cloudRecordService.queryTask(app, stream, callId, taskId, mediaServerId, isEnd, request.getScheme());
    }

    /**
     * 添加收藏
     *
     * @param app 应用名
     * @param stream 流ID
     * @param mediaServerId 流媒体ID
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @param callId 鉴权ID
     * @param recordId 录像记录的ID，用于精准收藏一个视频文件
     * @return
     */
    @ResponseBody
    @GetMapping("/collect/add")
    public int addCollect(@RequestParam(required = false) String app, @RequestParam(required = false) String stream, @RequestParam(required = false) String mediaServerId, @RequestParam(required = false) String startTime, @RequestParam(required = false) String endTime, @RequestParam(required = false) String callId, @RequestParam(required = false) Integer recordId) {
        log.info("[云端录像] 添加收藏，app={}，stream={},mediaServerId={},startTime={},endTime={},callId={},recordId={}", app, stream, mediaServerId, startTime, endTime, callId, recordId);
        if (recordId != null) {
            return cloudRecordService.changeCollectById(recordId, true);
        } else {
            return cloudRecordService.changeCollect(true, app, stream, mediaServerId, startTime, endTime, callId);
        }
    }

    /**
     * 移除收藏
     *
     * @param app 应用名
     * @param stream 流ID
     * @param mediaServerId 流媒体ID
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @param callId 鉴权ID
     * @param recordId 录像记录的ID，用于精准精准移除一个视频文件的收藏
     * @return
     */
    @ResponseBody
    @GetMapping("/collect/delete")
    public int deleteCollect(@RequestParam(required = false) String app, @RequestParam(required = false) String stream, @RequestParam(required = false) String mediaServerId, @RequestParam(required = false) String startTime, @RequestParam(required = false) String endTime, @RequestParam(required = false) String callId, @RequestParam(required = false) Integer recordId) {
        log.info("[云端录像] 移除收藏，app={}，stream={},mediaServerId={},startTime={},endTime={},callId={},recordId={}", app, stream, mediaServerId, startTime, endTime, callId, recordId);
        if (recordId != null) {
            return cloudRecordService.changeCollectById(recordId, false);
        } else {
            return cloudRecordService.changeCollect(false, app, stream, mediaServerId, startTime, endTime, callId);
        }
    }

    /**
     * 获取播放地址
     *
     * @param recordId 录像记录的ID
     * @return
     */
    @PreAuthorize("@ss.hasAnyPermi('wvp:record:play,wvp:record:download')")
    @ResponseBody
    @GetMapping("/play/path")
    public AjaxResult getPlayUrlPath(@RequestParam(required = true) Integer recordId) {
        return success(cloudRecordService.getPlayUrlPath(recordId));
    }

    /************************* 以下这些接口只适合wvp和zlm部署在同一台服务器的情况，且wvp只有一个zlm节点的情况 ***************************************/

    /**
     * 下载指定录像文件的压缩包
     *
     * @param query         检索内容
     * @param app           应用名
     * @param stream        流ID
     * @param startTime     开始时间(yyyy-MM-dd HH:mm:ss)
     * @param endTime       结束时间(yyyy-MM-dd HH:mm:ss)
     * @param mediaServerId 流媒体ID，置空则查询全部流媒体
     * @param callId        每次录像的唯一标识，置空则查询全部流媒体
     * @param ids           指定的Id
     */
    @ResponseBody
    @GetMapping("/zip")
    public void downloadZipFile(HttpServletResponse response, @RequestParam(required = false) String query, @RequestParam(required = false) String app, @RequestParam(required = false) String stream, @RequestParam(required = false) String startTime, @RequestParam(required = false) String endTime, @RequestParam(required = false) String mediaServerId, @RequestParam(required = false) String callId, @RequestParam(required = false) List<Integer> ids

    ) {
        log.info("[下载指定录像文件的压缩包] 查询 app->{}, stream->{}, mediaServerId->{}, startTime->{}, endTime->{}, callId->{}", app, stream, mediaServerId, startTime, endTime, callId);

        List<MediaServer> mediaServers;
        if (!ObjectUtils.isEmpty(mediaServerId)) {
            mediaServers = new ArrayList<>();
            MediaServer mediaServer = mediaServerService.getOne(mediaServerId);
            if (mediaServer == null) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到流媒体: " + mediaServerId);
            }
            mediaServers.add(mediaServer);
        } else {
            mediaServers = mediaServerService.getAll();
        }
        if (mediaServers.isEmpty()) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "当前无流媒体");
        }
        if (query != null && ObjectUtils.isEmpty(query.trim())) {
            query = null;
        }
        if (app != null && ObjectUtils.isEmpty(app.trim())) {
            app = null;
        }
        if (stream != null && ObjectUtils.isEmpty(stream.trim())) {
            stream = null;
        }
        if (startTime != null && ObjectUtils.isEmpty(startTime.trim())) {
            startTime = null;
        }
        if (endTime != null && ObjectUtils.isEmpty(endTime.trim())) {
            endTime = null;
        }
        if (callId != null && ObjectUtils.isEmpty(callId.trim())) {
            callId = null;
        }
        if (stream != null && callId != null) {
            response.addHeader("Content-Disposition", "attachment;filename=" + stream + "_" + callId + ".zip");
        }
        List<CloudRecordItem> cloudRecordItemList = cloudRecordService.getAllList(query, app, stream, startTime, endTime, mediaServers, callId, ids);
        if (ObjectUtils.isEmpty(cloudRecordItemList)) {
            return;
        }
        try {
            ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
            for (CloudRecordItem cloudRecordItem : cloudRecordItemList) {
                zos.putNextEntry(new ZipEntry(DateUtil.timestampMsToUrlToyyyy_MM_dd_HH_mm_ss(cloudRecordItem.getStartTime()) + ".mp4"));
                File file = new File(cloudRecordItem.getFilePath());
                if (!file.exists() || file.isDirectory()) {
                    continue;
                }
                FileInputStream fis = new FileInputStream(cloudRecordItem.getFilePath());
                byte[] buf = new byte[2 * 1024];
                int len;
                while ((len = fis.read(buf)) != -1) {
                    zos.write(buf, 0, len);
                }
                zos.closeEntry();
                fis.close();
            }
            zos.close();
        } catch (IOException e) {
            log.error("[下载指定录像文件的压缩包] 失败： 查询 app->{}, stream->{}, mediaServerId->{}, startTime->{}, endTime->{}, callId->{}", app, stream, mediaServerId, startTime, endTime, callId, e);
        }
    }

    /**
     * 查询云端录像列表
     *
     * @param query         检索内容
     * @param app           应用名
     * @param stream        流ID
     * @param pageNum       当前页
     * @param pageSize      每页查询数量
     * @param startTime     开始时间(yyyy-MM-dd HH:mm:ss)
     * @param endTime       结束时间(yyyy-MM-dd HH:mm:ss)
     * @param mediaServerId 流媒体ID，置空则查询全部流媒体
     * @param callId        每次录像的唯一标识，置空则查询全部流媒体
     * @param remoteHost    拼接播放地址时使用的远程地址
     */
    @ResponseBody
    @GetMapping("/list-url")
    public TableDataInfo getListWithUrl(
            HttpServletRequest request,
            @RequestParam(required = false) String query,
            @RequestParam(required = false) String app,
            @RequestParam(required = false) String stream,
            @RequestParam int pageNum,
            @RequestParam int pageSize,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            @RequestParam(required = false) String mediaServerId,
            @RequestParam(required = false) String callId,
            @RequestParam(required = false) String remoteHost

    ) {
        log.info("[云端录像] 查询URL app->{}, stream->{}, mediaServerId->{}, pageNum->{}, pageSize->{}, startTime->{}, endTime->{}, callId->{}",
                app, stream, mediaServerId, pageNum, pageSize, startTime, endTime, callId);

        List<MediaServer> mediaServers;
        if (!ObjectUtils.isEmpty(mediaServerId)) {
            mediaServers = new ArrayList<>();
            MediaServer mediaServer = mediaServerService.getOne(mediaServerId);
            if (mediaServer == null) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到流媒体: " + mediaServerId);
            }
            mediaServers.add(mediaServer);
        } else {
            mediaServers = mediaServerService.getAll();
        }
        if (mediaServers.isEmpty()) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "当前无流媒体");
        }
        if (query != null && ObjectUtils.isEmpty(query.trim())) {
            query = null;
        }
        if (app != null && ObjectUtils.isEmpty(app.trim())) {
            app = null;
        }
        if (stream != null && ObjectUtils.isEmpty(stream.trim())) {
            stream = null;
        }
        if (startTime != null && ObjectUtils.isEmpty(startTime.trim())) {
            startTime = null;
        }
        if (endTime != null && ObjectUtils.isEmpty(endTime.trim())) {
            endTime = null;
        }
        if (callId != null && ObjectUtils.isEmpty(callId.trim())) {
            callId = null;
        }
        MediaServer mediaServer = mediaServerService.getDefaultMediaServer();
        if (mediaServer == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到流媒体节点");
        }
        if (remoteHost == null) {
            remoteHost = request.getScheme() + "://" + request.getLocalAddr() + ":" + (request.getScheme().equals("https") ? mediaServer.getHttpSSlPort() : mediaServer.getHttpPort());
        }
        startPage();
        List<CloudRecordItem> list = cloudRecordService.getList(pageNum, pageSize, query, app, stream, startTime, endTime, mediaServers, callId);
        List<CloudRecordUrl> cloudRecordUrlList = new ArrayList<>(list.size());
        if (!ObjectUtils.isEmpty(list)) {
            for (CloudRecordItem cloudRecordItem : list) {
                CloudRecordUrl cloudRecordUrl = new CloudRecordUrl();
                cloudRecordUrl.setId(cloudRecordItem.getId());
                cloudRecordUrl.setDownloadUrl(remoteHost + "/index/api/downloadFile?file_path=" + cloudRecordItem.getFilePath() + "&save_name=" + cloudRecordItem.getStream() + "_" + cloudRecordItem.getCallId() + "_" + DateUtil.timestampMsToUrlToyyyy_MM_dd_HH_mm_ss(cloudRecordItem.getStartTime()));
                cloudRecordUrl.setPlayUrl(remoteHost + "/index/api/downloadFile?file_path=" + cloudRecordItem.getFilePath());
                cloudRecordUrlList.add(cloudRecordUrl);
            }
        }
        return getDataTable(cloudRecordUrlList);
    }
}
