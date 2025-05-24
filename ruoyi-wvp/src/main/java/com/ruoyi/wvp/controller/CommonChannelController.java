package com.ruoyi.wvp.controller;


import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.wvp.gb28181.bean.CommonGBChannel;
import com.ruoyi.wvp.gb28181.controller.bean.ChannelToGroupByGbDeviceParam;
import com.ruoyi.wvp.gb28181.controller.bean.ChannelToGroupParam;
import com.ruoyi.wvp.gb28181.controller.bean.ChannelToRegionByGbDeviceParam;
import com.ruoyi.wvp.gb28181.controller.bean.ChannelToRegionParam;
import com.ruoyi.wvp.gb28181.service.IGbChannelPlayService;
import com.ruoyi.wvp.gb28181.service.IGbChannelService;
import com.ruoyi.wvp.media.service.IMediaServerService;
import com.ruoyi.wvp.service.bean.ErrorCallback;
import com.ruoyi.wvp.service.bean.InviteErrorCode;
import com.ruoyi.wvp.storager.IRedisCatchStorage;
import com.ruoyi.wvp.vmanager.bean.StreamContent;
import com.ruoyi.wvp.vmanager.bean.WVPResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import javax.servlet.http.HttpServletRequest;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;


/**
 * 全局通道管理
 */
@RestController
@Slf4j
@RequestMapping(value = "/api/common/channel")
public class CommonChannelController extends BaseController {

    @Autowired
    private IRedisCatchStorage redisCatchStorage;

    @Autowired
    private IGbChannelService channelService;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private IGbChannelPlayService channelPlayService;

    @Autowired
    private UserSetting userSetting;

    /**
     * 获取通道信息
     *
     * @param id 通道的数据库自增Id
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:query')")
    @GetMapping(value = "/one/{id}")
    public AjaxResult getOne(@PathVariable int id) {
        return success(channelService.getOne(id));
    }

    /**
     * 获取通道信息
     *
     * @return
     */
    @GetMapping("/industry/list")
    public AjaxResult getIndustryCodeList() {
        return success(channelService.getIndustryCodeList());
    }

    /**
     * 获取通道类型列表
     *
     * @return
     */
    @GetMapping("/type/list")
    public AjaxResult getDeviceTypeList() {
        return success(channelService.getDeviceTypeList());
    }

    /**
     * 获取网络标识列表
     *
     * @return
     */
    @GetMapping("/network/identification/list")
    public AjaxResult getNetworkIdentificationTypeList() {
        return success(channelService.getNetworkIdentificationTypeList());
    }

    /**
     * 修改通道信息
     *
     * @param channel
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:edit')")
    @PostMapping("/update")
    public AjaxResult update(@RequestBody CommonGBChannel channel) {
        channelService.update(channel);
        return success();
    }

    /**
     * 重置通道
     *
     * @param id
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:edit')")
    @PostMapping("/reset/{id}")
    public AjaxResult reset(@PathVariable Integer id) {
        channelService.reset(id);
        return success();
    }

    /**
     * 新增通道
     *
     * @param channel 通道
     * @return
     */
    @PostMapping("/add")
    public AjaxResult add(@RequestBody CommonGBChannel channel) {
        channelService.add(channel);
        return success(channel);
    }

    /**
     * 查询通道列表
     *
     * @param page 当前页
     * @param count 每页查询数量
     * @param query 查询内容
     * @param online 是否在线
     * @param hasRecordPlan 是否已设置录制计划
     * @param channelType 通道类型， 0：国标设备，1：推流设备，2：拉流代理
     * @return
     */
    @GetMapping("/list")
    public PageInfo<CommonGBChannel> queryList(int page, int count,
                                               @RequestParam(required = false) String query,
                                               @RequestParam(required = false) Boolean online,
                                               @RequestParam(required = false) Boolean hasRecordPlan,
                                               @RequestParam(required = false) Integer channelType) {
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        return channelService.queryList(page, count, query, online, hasRecordPlan, channelType);
    }

    /**
     * 获取通道列表
     *
     * @param pageNum     当前页
     * @param pageSize    每页查询数量
     * @param query       查询内容
     * @param online      是否在线
     * @param channelType 通道类型， 0：国标设备，1：推流设备，2：拉流代理
     * @param civilCode   行政区划
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:civilcodeList')")
    @GetMapping("/civilcode/list")
    public TableDataInfo queryListByCivilCode(int pageNum, int pageSize,
                                              @RequestParam(required = false) String query,
                                              @RequestParam(required = false) Boolean online,
                                              @RequestParam(required = false) Integer channelType,
                                              @RequestParam(required = false) String civilCode) {
        startPage();
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        List<CommonGBChannel> list = channelService.queryListByCivilCode(pageNum, pageSize, query, online, channelType, civilCode);
        return getDataTable(list);
    }

    /**
     * 根据ParentId获取通道列表
     *
     * @param pageNum       当前页
     * @param pageSize      每页查询数量
     * @param query         查询内容
     * @param online        是否在线
     * @param channelType   通道类型， 0：国标设备，1：推流设备，2：拉流代理
     * @param groupDeviceId 业务分组下的父节点ID
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:civilcodeList')")
    @GetMapping("/parent/list")
    public TableDataInfo queryListByParentId(int pageNum, int pageSize,
                                             @RequestParam(required = false) String query,
                                             @RequestParam(required = false) Boolean online,
                                             @RequestParam(required = false) Integer channelType,
                                             @RequestParam(required = false) String groupDeviceId) {
        startPage();
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        List<CommonGBChannel> list = channelService.queryListByParentId(pageNum, pageSize, query, online, channelType, groupDeviceId);
        return getDataTable(list);
    }

    /**
     * 添加通道
     *
     * @param param
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:addRegionChannel')")
    @PostMapping("/region/add")
    public AjaxResult addChannelToRegion(@RequestBody ChannelToRegionParam param) {
        Assert.notEmpty(param.getChannelIds(), "通道ID不可为空");
        Assert.hasLength(param.getCivilCode(), "未添加行政区划");
        channelService.addChannelToRegion(param.getCivilCode(), param.getChannelIds());
        return success();
    }

    /**
     * 删除通道
     *
     * @param param
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:deleteRegionChannel')")
    @PostMapping("/region/delete")
    public AjaxResult deleteChannelToRegion(@RequestBody ChannelToRegionParam param) {
        Assert.isTrue(!param.getChannelIds().isEmpty() || !ObjectUtils.isEmpty(param.getCivilCode()), "参数异常");
        channelService.deleteChannelToRegion(param.getCivilCode(), param.getChannelIds());
        return success();
    }

    @PostMapping("/region/device/add")
    public void addChannelToRegionByGbDevice(@RequestBody ChannelToRegionByGbDeviceParam param) {
        Assert.notEmpty(param.getDeviceIds(), "参数异常");
        Assert.hasLength(param.getCivilCode(), "未添加行政区划");
        channelService.addChannelToRegionByGbDevice(param.getCivilCode(), param.getDeviceIds());
    }

    @PostMapping("/region/device/delete")
    public void deleteChannelToRegionByGbDevice(@RequestBody ChannelToRegionByGbDeviceParam param) {
        Assert.notEmpty(param.getDeviceIds(), "参数异常");
        channelService.deleteChannelToRegionByGbDevice(param.getDeviceIds());
    }

    /**
     * 添加通道信息
     *
     * @param param
     */
    @PostMapping("/group/add")
    public AjaxResult addChannelToGroup(@RequestBody ChannelToGroupParam param) {
        Assert.notEmpty(param.getChannelIds(), "通道ID不可为空");
        Assert.hasLength(param.getParentId(), "未添加上级分组编号");
        Assert.hasLength(param.getBusinessGroup(), "未添加业务分组");
        channelService.addChannelToGroup(param.getParentId(), param.getBusinessGroup(), param.getChannelIds());
        return success();
    }

    /**
     * 删除通道
     *
     * @param param
     */
    @PreAuthorize("@ss.hasPermi('wvp:channel:deleteGroupChannel')")
    @PostMapping("/group/delete")
    public AjaxResult deleteChannelToGroup(@RequestBody ChannelToGroupParam param) {
        Assert.isTrue(!param.getChannelIds().isEmpty()
                        || (!ObjectUtils.isEmpty(param.getParentId()) && !ObjectUtils.isEmpty(param.getBusinessGroup())),
                "参数异常");
        channelService.deleteChannelToGroup(param.getParentId(), param.getBusinessGroup(), param.getChannelIds());
        return success();
    }

    @PreAuthorize("@ss.hasPermi('wvp:channel:addGroupChannel')")
    @PostMapping("/group/device/add")
    public void addChannelToGroupByGbDevice(@RequestBody ChannelToGroupByGbDeviceParam param) {
        Assert.notEmpty(param.getDeviceIds(), "参数异常");
        Assert.hasLength(param.getParentId(), "未添加上级分组编号");
        Assert.hasLength(param.getBusinessGroup(), "未添加业务分组");
        channelService.addChannelToGroupByGbDevice(param.getParentId(), param.getBusinessGroup(), param.getDeviceIds());
    }

    @PostMapping("/group/device/delete")
    public void deleteChannelToGroupByGbDevice(@RequestBody ChannelToGroupByGbDeviceParam param) {
        Assert.notEmpty(param.getDeviceIds(), "参数异常");
        channelService.deleteChannelToGroupByGbDevice(param.getDeviceIds());
    }

    @GetMapping("/play")
    public DeferredResult<WVPResult<StreamContent>> deleteChannelToGroupByGbDevice(HttpServletRequest request, Integer channelId) {
        Assert.notNull(channelId, "参数异常");
        CommonGBChannel channel = channelService.getOne(channelId);
        Assert.notNull(channel, "通道不存在");

        DeferredResult<WVPResult<StreamContent>> result = new DeferredResult<>(userSetting.getPlayTimeout().longValue());

        ErrorCallback<StreamInfo> callback = (code, msg, streamInfo) -> {
            if (code == InviteErrorCode.SUCCESS.getCode()) {
                WVPResult<StreamContent> wvpResult = WVPResult.success();
                if (streamInfo != null) {
                    if (userSetting.getUseSourceIpAsStreamIp()) {
                        streamInfo = streamInfo.clone();//深拷贝
                        String host;
                        try {
                            URL url = new URL(request.getRequestURL().toString());
                            host = url.getHost();
                        } catch (MalformedURLException e) {
                            host = request.getLocalAddr();
                        }
                        streamInfo.channgeStreamIp(host);
                    }
                    if (!ObjectUtils.isEmpty(streamInfo.getMediaServer().getTranscodeSuffix())
                            && !"null".equalsIgnoreCase(streamInfo.getMediaServer().getTranscodeSuffix())) {
                        streamInfo.setStream(streamInfo.getStream() + "_" + streamInfo.getMediaServer().getTranscodeSuffix());
                    }
                    wvpResult.setData(new StreamContent(streamInfo));
                } else {
                    wvpResult.setCode(code);
                    wvpResult.setMsg(msg);
                }

                result.setResult(wvpResult);
            } else {
                result.setResult(WVPResult.fail(code, msg));
            }
        };
        channelPlayService.play(channel, null, userSetting.getRecordSip(), callback);
        return result;
    }
}
