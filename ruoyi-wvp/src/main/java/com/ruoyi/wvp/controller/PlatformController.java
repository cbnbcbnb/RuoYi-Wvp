package com.ruoyi.wvp.controller;

import com.alibaba.fastjson2.JSONObject;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.wvp.conf.SipConfig;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Platform;
import com.ruoyi.wvp.gb28181.bean.PlatformChannel;
import com.ruoyi.wvp.gb28181.bean.SubscribeHolder;
import com.ruoyi.wvp.gb28181.controller.bean.UpdateChannelParam;
import com.ruoyi.wvp.gb28181.service.IPlatformChannelService;
import com.ruoyi.wvp.gb28181.service.IPlatformService;
import com.ruoyi.wvp.utils.DateUtil;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.WVPResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

/**
 * 级联平台管理
 */
@Slf4j
@RestController
@RequestMapping("/api/platform")
public class PlatformController extends BaseController {

    @Autowired
    private IPlatformChannelService platformChannelService;

    @Autowired
    private SubscribeHolder subscribeHolder;

    @Autowired
    private SipConfig sipConfig;

    @Autowired
    private IPlatformService platformService;


    /**
     * 获取上级平台信息
     *
     * @return
     */
    @GetMapping("/server_config")
    public AjaxResult serverConfig() {
        JSONObject result = new JSONObject();
        result.put("deviceIp", sipConfig.getShowIp());
        result.put("devicePort", sipConfig.getPort());
        result.put("username", sipConfig.getId());
        result.put("password", sipConfig.getPassword());
        return success(result);
    }

    /**
     * 获取上级平台信息
     *
     * @param id 平台国标编号
     * @return
     */
    @GetMapping("/info/{id}")
    public Platform getPlatform(@PathVariable String id) {
        Platform parentPlatform = platformService.queryPlatformByServerGBId(id);
        if (parentPlatform != null) {
            return parentPlatform;
        } else {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "未查询到此平台");
        }
    }

    /**
     * 获取上级平台列表
     *
     * @param page  当前页
     * @param count 每页数量
     * @param query 查询内容
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:platform:list')")
    @GetMapping("/query")
    public AjaxResult platforms(int page, int count,
                                @RequestParam(required = false) String query) {

        PageInfo<Platform> parentPlatformPageInfo = platformService.queryPlatformList(page, count, query);
        if (parentPlatformPageInfo != null && !parentPlatformPageInfo.getList().isEmpty()) {
            for (Platform platform : parentPlatformPageInfo.getList()) {
                platform.setMobilePositionSubscribe(subscribeHolder.getMobilePositionSubscribe(platform.getServerGBId()) != null);
                platform.setCatalogSubscribe(subscribeHolder.getCatalogSubscribe(platform.getServerGBId()) != null);
            }
        }
        return success(parentPlatformPageInfo);
    }

    /**
     * 添加上级平台信息
     *
     * @param platform
     */
    @PreAuthorize("@ss.hasPermi('wvp:platform:add')")
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult add(@RequestBody Platform platform) {

        if (log.isDebugEnabled()) {
            log.debug("保存上级平台信息API调用");
        }
        Assert.notNull(platform.getName(), "平台名称不可为空");
        Assert.notNull(platform.getServerGBId(), "上级平台国标编号不可为空");
        Assert.notNull(platform.getServerIp(), "上级平台IP不可为空");
        Assert.isTrue(platform.getServerPort() > 0 && platform.getServerPort() < 65535, "上级平台端口异常");
        Assert.notNull(platform.getDeviceGBId(), "本平台国标编号不可为空");

        if (ObjectUtils.isEmpty(platform.getServerGBDomain())) {
            platform.setServerGBDomain(platform.getServerGBId().substring(0, 6));
        }

        if (platform.getExpires() <= 0) {
            platform.setExpires(3600);
        }

        if (platform.getKeepTimeout() <= 0) {
            platform.setKeepTimeout(60);
        }

        if (ObjectUtils.isEmpty(platform.getTransport())) {
            platform.setTransport("UDP");
        }

        if (ObjectUtils.isEmpty(platform.getCharacterSet())) {
            platform.setCharacterSet("GB2312");
        }

        Platform parentPlatformOld = platformService.queryPlatformByServerGBId(platform.getServerGBId());
        if (parentPlatformOld != null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "平台 " + platform.getServerGBId() + " 已存在");
        }
        platform.setCreateTime(DateUtil.getNow());
        platform.setUpdateTime(DateUtil.getNow());
        boolean updateResult = platformService.add(platform);

        if (!updateResult) {
            throw new ControllerException(ErrorCode.ERROR100);
        }
        return success();
    }

    /**
     * 更新上级平台信息
     *
     * @param parentPlatform
     */
    @PreAuthorize("@ss.hasPermi('wvp:platform:edit')")
    @PostMapping("/update")
    @ResponseBody
    public AjaxResult updatePlatform(@RequestBody Platform parentPlatform) {
        if (log.isDebugEnabled()) {
            log.debug("保存上级平台信息API调用");
        }
        if (ObjectUtils.isEmpty(parentPlatform.getName())
                || ObjectUtils.isEmpty(parentPlatform.getServerGBId())
                || ObjectUtils.isEmpty(parentPlatform.getServerGBDomain())
                || ObjectUtils.isEmpty(parentPlatform.getServerIp())
                || ObjectUtils.isEmpty(parentPlatform.getServerPort())
                || ObjectUtils.isEmpty(parentPlatform.getDeviceGBId())
                || ObjectUtils.isEmpty(parentPlatform.getExpires())
                || ObjectUtils.isEmpty(parentPlatform.getKeepTimeout())
                || ObjectUtils.isEmpty(parentPlatform.getTransport())
                || ObjectUtils.isEmpty(parentPlatform.getCharacterSet())
        ) {
            throw new ControllerException(ErrorCode.ERROR400);
        }
        platformService.update(parentPlatform);
        return success();
    }

    /**
     * 删除上级平台信息
     *
     * @param id 上级平台ID
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:platform:delete')")
    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public AjaxResult deletePlatform(@PathVariable Integer id) {

        if (log.isDebugEnabled()) {
            log.debug("删除上级平台API调用");
        }
        DeferredResult<Object> deferredResult = new DeferredResult<>();

        platformService.delete(id, (object) -> {
            deferredResult.setResult(WVPResult.success());
        });
        return success(deferredResult);
    }

    /**
     * 判断上级平台是否存在
     *
     * @param serverGBId 上级平台的国标编号
     * @return
     */
    @GetMapping("/exit/{serverGBId}")
    @ResponseBody
    public AjaxResult exitPlatform(@PathVariable String serverGBId) {
        Platform platform = platformService.queryPlatformByServerGBId(serverGBId);
        return success(platform != null);
    }

    /**
     * 查询上级平台列表
     *
     * @param page        当前页
     * @param count       每页条数
     * @param platformId  上级平台的数据ID
     * @param query       通道类型， 0：国标设备，1：推流设备，2：拉流代理
     * @param channelType 查询内容
     * @param online      是否在线
     * @param hasShare    是否已经共享
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:platform:channelList')")
    @GetMapping("/channel/list")
    @ResponseBody
    public AjaxResult queryChannelList(int page, int count,
                                       @RequestParam(required = false) Integer platformId,
                                       @RequestParam(required = false) String query,
                                       @RequestParam(required = false) Integer channelType,
                                       @RequestParam(required = false) Boolean online,
                                       @RequestParam(required = false) Boolean hasShare) {

        Assert.notNull(platformId, "上级平台的数据ID不可为NULL");
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        return success(platformChannelService.queryChannelList(page, count, query, channelType, online, platformId, hasShare));
    }

    @PreAuthorize("@ss.hasPermi('wvp:platform:channelAdd')")
    @PostMapping("/channel/add")
    @ResponseBody
    public AjaxResult addChannel(@RequestBody UpdateChannelParam param) {
        if (log.isDebugEnabled()) {
            log.debug("给上级平台添加国标通道API调用");
        }
        int result = 0;
        if (param.getChannelIds() == null || param.getChannelIds().isEmpty()) {
            if (param.isAll()) {
                log.info("[国标级联]添加所有通道到上级平台， {}", param.getPlatformId());
                result = platformChannelService.addAllChannel(param.getPlatformId());
            }
        } else {
            result = platformChannelService.addChannels(param.getPlatformId(), param.getChannelIds());
        }
        if (result <= 0) {
            throw new ControllerException(ErrorCode.ERROR100);
        }
        return success();
    }

    @PreAuthorize("@ss.hasPermi('wvp:platform:channelRemove')")
    @DeleteMapping("/channel/remove")
    @ResponseBody
    public AjaxResult delChannelForGB(@RequestBody UpdateChannelParam param) {

        if (log.isDebugEnabled()) {
            log.debug("给上级平台删除国标通道API调用");
        }
        int result = 0;
        if (param.getChannelIds() == null || param.getChannelIds().isEmpty()) {
            if (param.isAll()) {
                log.info("[国标级联]移除所有通道，上级平台， {}", param.getPlatformId());
                result = platformChannelService.removeAllChannel(param.getPlatformId());
            }
        } else {
            result = platformChannelService.removeChannels(param.getPlatformId(), param.getChannelIds());
        }
        if (result <= 0) {
            throw new ControllerException(ErrorCode.ERROR100);
        }
        return success();
    }

    /**
     * 上级平台推送通道
     *
     * @param id 平台ID
     */
    @PreAuthorize("@ss.hasPermi('wvp:platform:push')")
    @GetMapping("/channel/push//{id}")
    @ResponseBody
    public AjaxResult pushChannel(@PathVariable Integer id) {
        Assert.notNull(id, "平台ID不可为空");
        platformChannelService.pushChannel(id);
        return success();
    }

    @PostMapping("/channel/device/add")
    @ResponseBody
    public AjaxResult addChannelByDevice(@RequestBody UpdateChannelParam param) {
        Assert.notNull(param.getPlatformId(), "平台ID不可为空");
        Assert.notNull(param.getDeviceIds(), "设备ID不可为空");
        Assert.notEmpty(param.getDeviceIds(), "设备ID不可为空");
        platformChannelService.addChannelByDevice(param.getPlatformId(), param.getDeviceIds());
        return success();
    }

    @PostMapping("/channel/device/remove")
    @ResponseBody
    public AjaxResult removeChannelByDevice(@RequestBody UpdateChannelParam param) {
        Assert.notNull(param.getPlatformId(), "平台ID不可为空");
        Assert.notNull(param.getDeviceIds(), "设备ID不可为空");
        Assert.notEmpty(param.getDeviceIds(), "设备ID不可为空");
        platformChannelService.removeChannelByDevice(param.getPlatformId(), param.getDeviceIds());
        return success();
    }

    @PostMapping("/channel/custom/update")
    @ResponseBody
    public void updateCustomChannel(@RequestBody PlatformChannel channel) {
        Assert.isTrue(channel.getId() > 0, "共享通道ID必须存在");
        platformChannelService.updateCustomChannel(channel);
    }
}
