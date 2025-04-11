package com.ruoyi.wvp.gb28181.controller;


import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.wvp.gb28181.bean.CommonGBChannel;
import com.ruoyi.wvp.gb28181.bean.DeviceType;
import com.ruoyi.wvp.gb28181.bean.IndustryCodeType;
import com.ruoyi.wvp.gb28181.bean.NetworkIdentificationType;
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
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import javax.servlet.http.HttpServletRequest;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;


@Tag(name = "全局通道管理")
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

    @Parameter(name = "page", description = "当前页", required = true)
    @Parameter(name = "count", description = "每页查询数量", required = true)
    @Parameter(name = "query", description = "查询内容")
    @Parameter(name = "online", description = "是否在线")
    @Parameter(name = "hasRecordPlan", description = "是否已设置录制计划")
    @Parameter(name = "channelType", description = "通道类型， 0：国标设备，1：推流设备，2：拉流代理")
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

    @Parameter(name = "page", description = "当前页", required = true)
    @Parameter(name = "count", description = "每页查询数量", required = true)
    @Parameter(name = "query", description = "查询内容")
    @Parameter(name = "online", description = "是否在线")
    @Parameter(name = "channelType", description = "通道类型， 0：国标设备，1：推流设备，2：拉流代理")
    @Parameter(name = "civilCode", description = "行政区划")
    @GetMapping("/civilcode/list")
    public PageInfo<CommonGBChannel> queryListByCivilCode(int page, int count,
                                                          @RequestParam(required = false) String query,
                                                          @RequestParam(required = false) Boolean online,
                                                          @RequestParam(required = false) Integer channelType,
                                                          @RequestParam(required = false) String civilCode) {
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        return channelService.queryListByCivilCode(page, count, query, online, channelType, civilCode);
    }

    @Parameter(name = "page", description = "当前页", required = true)
    @Parameter(name = "count", description = "每页查询数量", required = true)
    @Parameter(name = "query", description = "查询内容")
    @Parameter(name = "online", description = "是否在线")
    @Parameter(name = "channelType", description = "通道类型， 0：国标设备，1：推流设备，2：拉流代理")
    @Parameter(name = "groupDeviceId", description = "业务分组下的父节点ID")
    @GetMapping("/parent/list")
    public PageInfo<CommonGBChannel> queryListByParentId(int page, int count,
                                                         @RequestParam(required = false) String query,
                                                         @RequestParam(required = false) Boolean online,
                                                         @RequestParam(required = false) Integer channelType,
                                                         @RequestParam(required = false) String groupDeviceId) {
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        return channelService.queryListByParentId(page, count, query, online, channelType, groupDeviceId);
    }

    @PostMapping("/region/add")
    public void addChannelToRegion(@RequestBody ChannelToRegionParam param) {
        Assert.notEmpty(param.getChannelIds(), "通道ID不可为空");
        Assert.hasLength(param.getCivilCode(), "未添加行政区划");
        channelService.addChannelToRegion(param.getCivilCode(), param.getChannelIds());
    }

    @PostMapping("/region/delete")
    public void deleteChannelToRegion(@RequestBody ChannelToRegionParam param) {
        Assert.isTrue(!param.getChannelIds().isEmpty() || !ObjectUtils.isEmpty(param.getCivilCode()), "参数异常");
        channelService.deleteChannelToRegion(param.getCivilCode(), param.getChannelIds());
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

    @PostMapping("/group/add")
    public void addChannelToGroup(@RequestBody ChannelToGroupParam param) {
        Assert.notEmpty(param.getChannelIds(), "通道ID不可为空");
        Assert.hasLength(param.getParentId(), "未添加上级分组编号");
        Assert.hasLength(param.getBusinessGroup(), "未添加业务分组");
        channelService.addChannelToGroup(param.getParentId(), param.getBusinessGroup(), param.getChannelIds());
    }

    @PostMapping("/group/delete")
    public void deleteChannelToGroup(@RequestBody ChannelToGroupParam param) {
        Assert.isTrue(!param.getChannelIds().isEmpty()
                        || (!ObjectUtils.isEmpty(param.getParentId()) && !ObjectUtils.isEmpty(param.getBusinessGroup())),
                "参数异常");
        channelService.deleteChannelToGroup(param.getParentId(), param.getBusinessGroup(), param.getChannelIds());
    }

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
