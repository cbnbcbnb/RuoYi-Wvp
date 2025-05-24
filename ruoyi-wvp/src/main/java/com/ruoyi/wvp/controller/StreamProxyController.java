package com.ruoyi.wvp.controller;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.streamProxy.bean.StreamProxy;
import com.ruoyi.wvp.streamProxy.bean.StreamProxyParam;
import com.ruoyi.wvp.streamProxy.service.IStreamProxyPlayService;
import com.ruoyi.wvp.streamProxy.service.IStreamProxyService;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.StreamContent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 拉流代理
 */
@SuppressWarnings("rawtypes")
@RestController
@Slf4j
@RequestMapping(value = "/api/proxy")
public class StreamProxyController extends BaseController {

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private IStreamProxyService streamProxyService;

    @Autowired
    private IStreamProxyPlayService streamProxyPlayService;


    /**
     * 分页获取代理
     *
     * @param pageNum       当前页
     * @param pageSize      每页查询数量
     * @param query         查询内容
     * @param pulling       是否正在拉流
     * @param mediaServerId 流媒体ID
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:proxy:list')")
    @GetMapping(value = "/list")
    @ResponseBody
    public TableDataInfo list(@RequestParam(required = false) Integer pageNum,
                              @RequestParam(required = false) Integer pageSize,
                              @RequestParam(required = false) String query,
                              @RequestParam(required = false) Boolean pulling,
                              @RequestParam(required = false) String mediaServerId) {

        if (ObjectUtils.isEmpty(mediaServerId)) {
            mediaServerId = null;
        }
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        startPage();
        List<StreamProxy> list = streamProxyService.getAll(pageNum, pageSize, query, pulling, mediaServerId);
        return getDataTable(list);
    }

    /**
     * 获取代理
     *
     * @param app 应用名
     * @param stream 流Id
     * @return
     */
    @GetMapping(value = "/one")
    @ResponseBody
    public StreamProxy one(String app, String stream) {

        return streamProxyService.getStreamProxyByAppAndStream(app, stream);
    }

    @PostMapping(value = "/save")
    @ResponseBody
    public StreamContent save(@RequestBody StreamProxyParam param) {
        log.info("添加代理： " + JSONObject.toJSONString(param));
        if (ObjectUtils.isEmpty(param.getMediaServerId())) {
            param.setMediaServerId("auto");
        }
        if (ObjectUtils.isEmpty(param.getType())) {
            param.setType("default");
        }

        StreamInfo streamInfo = streamProxyService.save(param);
        if (param.isEnable()) {
            if (streamInfo == null) {
                throw new ControllerException(ErrorCode.ERROR100.getCode(), ErrorCode.ERROR100.getMsg());
            } else {
                return new StreamContent(streamInfo);
            }
        } else {
            return null;
        }

    }

    /**
     * 新增拉流代理
     *
     * @param param
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:proxy:add')")
    @PostMapping(value = "/add")
    @ResponseBody
    public AjaxResult add(@RequestBody StreamProxy param) {
        log.info("添加代理： " + JSONObject.toJSONString(param));
        if (ObjectUtils.isEmpty(param.getRelatesMediaServerId())) {
            param.setRelatesMediaServerId(null);
        }
        if (ObjectUtils.isEmpty(param.getType())) {
            param.setType("default");
        }
        if (ObjectUtils.isEmpty(param.getGbId())) {
            param.setGbDeviceId(null);
        }
        streamProxyService.add(param);
        return success(param);
    }

    /**
     * 更新拉流代理
     *
     * @param param
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:proxy:edit')")
    @PostMapping(value = "/update")
    @ResponseBody
    public AjaxResult update(@RequestBody StreamProxy param) {
        log.info("更新代理： " + JSONObject.toJSONString(param));
        if (param.getId() == 0) {
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "缺少代理信息的ID");
        }
        if (ObjectUtils.isEmpty(param.getRelatesMediaServerId())) {
            param.setRelatesMediaServerId(null);
        }
        if (ObjectUtils.isEmpty(param.getGbId())) {
            param.setGbDeviceId(null);
        }
        streamProxyService.update(param);
        return success(param);
    }

    /**
     * 获取ffmpeg.cmd模板
     *
     * @param mediaServerId 流媒体ID
     * @return
     */
    @GetMapping(value = "/ffmpeg_cmd/list")
    @ResponseBody
    public AjaxResult getFFmpegCMDs(@RequestParam String mediaServerId) {
        log.debug("获取节点[ {} ]ffmpeg.cmd模板", mediaServerId);

        MediaServer mediaServerItem = mediaServerService.getOne(mediaServerId);
        if (mediaServerItem == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "流媒体： " + mediaServerId + "未找到");
        }
        return success(streamProxyService.getFFmpegCMDs(mediaServerItem));
    }

    /**
     * 移除代理
     *
     * @param app 应用名
     * @param stream 流id
     */
    @DeleteMapping(value = "/del")
    @ResponseBody
    public void del(@RequestParam String app, @RequestParam String stream) {
        log.info("移除代理： " + app + "/" + stream);
        if (app == null || stream == null) {
            throw new ControllerException(ErrorCode.ERROR400.getCode(), app == null ? "app不能为null" : "stream不能为null");
        } else {
            streamProxyService.delteByAppAndStream(app, stream);
        }
    }

    /**
     * 删除拉流代理
     *
     * @param id
     */
    @PreAuthorize("@ss.hasPermi('wvp:proxy:delete')")
    @DeleteMapping(value = "/delete/{id}")
    @ResponseBody
    public AjaxResult delete(@PathVariable int id) {
        log.info("移除代理： {}", id);
        streamProxyService.delete(id);
        return success();
    }

    /**
     * 播放
     *
     * @param id 代理Id
     * @return
     */
    @GetMapping(value = "/start")
    @ResponseBody
    @PreAuthorize("@ss.hasPermi('wvp:proxy:play')")
    public StreamContent start(int id) {
        log.info("播放代理： {}", id);
        StreamInfo streamInfo = streamProxyPlayService.start(id, null, null);
        if (streamInfo == null) {
            throw new RuntimeException(ErrorCode.ERROR400.getMsg());
        } else {
            return new StreamContent(streamInfo);
        }
    }

    /**
     * 停止拉流代理
     *
     * @param id 代理Id
     */
    @PreAuthorize("@ss.hasPermi('wvp:proxy:stop')")
    @PostMapping(value = "/stop/{id}")
    @ResponseBody
    public AjaxResult stop(@PathVariable int id) {
        log.info("停用代理： {}", id);
        streamProxyPlayService.stop(id);
        return success();
    }
}
