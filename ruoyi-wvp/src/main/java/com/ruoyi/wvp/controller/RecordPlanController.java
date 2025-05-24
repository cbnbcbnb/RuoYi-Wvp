package com.ruoyi.wvp.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.CommonGBChannel;
import com.ruoyi.wvp.gb28181.service.IDeviceChannelService;
import com.ruoyi.wvp.service.IRecordPlanService;
import com.ruoyi.wvp.service.bean.RecordPlan;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.recordPlan.bean.RecordPlanParam;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 录制计划
 */
@Slf4j
@RestController
@RequestMapping("/api/record/plan")
public class RecordPlanController extends BaseController {

    @Autowired
    private IRecordPlanService recordPlanService;

    @Autowired
    private IDeviceChannelService deviceChannelService;


    /**
     * 新增录制计划
     *
     * @param plan 计划
     */
    @PreAuthorize("@ss.hasPermi('wvp:record:add')")
    @ResponseBody
    @PostMapping("/add")
    public AjaxResult add(@RequestBody RecordPlan plan) {
        if (plan.getPlanItemList() == null || plan.getPlanItemList().isEmpty()) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "添加录制计划时，录制计划不可为空");
        }
        recordPlanService.add(plan);
        return success();
    }

    /**
     * 通道关联录制计划
     *
     * @param param
     */
    @PreAuthorize("@ss.hasAnyPermi('wvp:record:channelAdd,wvp:record:channelDelete')")
    @ResponseBody
    @PostMapping("/link")
    public AjaxResult link(@RequestBody RecordPlanParam param) {
        if (param.getAllLink() != null) {
            if (param.getAllLink()) {
                recordPlanService.linkAll(param.getPlanId());
            } else {
                recordPlanService.cleanAll(param.getPlanId());
            }
            return success();
        }

        if (param.getChannelIds() == null && param.getDeviceDbIds() == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "通道ID和国标设备ID不可都为NULL");
        }

        List<Integer> channelIds = new ArrayList<>();
        if (param.getChannelIds() != null) {
            channelIds.addAll(param.getChannelIds());
        } else {
            List<Integer> chanelIdList = deviceChannelService.queryChaneIdListByDeviceDbIds(param.getDeviceDbIds());
            if (chanelIdList != null && !chanelIdList.isEmpty()) {
                channelIds = chanelIdList;
            }
        }
        recordPlanService.link(channelIds, param.getPlanId());
        return success();
    }

    /**
     * 获取录制计划
     *
     * @param planId 计划ID
     * @return
     */
    @ResponseBody
    @GetMapping("/get/{planId}")
    public AjaxResult get(@PathVariable Integer planId) {
        if (planId == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "计划ID不可为NULL");
        }
        return success(recordPlanService.get(planId));
    }

    /**
     * 查询录制计划列表
     *
     * @param query    检索内容
     * @param pageNum  当前页
     * @param pageSize 每页查询数量
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:record:list')")
    @ResponseBody
    @GetMapping("/query")
    public TableDataInfo query(@RequestParam(required = false) String query, @RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        if (query != null && ObjectUtils.isEmpty(query.trim())) {
            query = null;
        }

        startPage();
        List<RecordPlan> list = recordPlanService.query(pageNum, pageSize, query);
        return getDataTable(list);
    }

    /**
     * 查询通道列表
     *
     * @param pageNum     当前页
     * @param pageSize    每页条数
     * @param planId      录制计划ID
     * @param query       通道类型， 0：国标设备，1：推流设备，2：拉流代理
     * @param channelType 查询内容
     * @param online      是否在线
     * @param hasLink     是否已经关联
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:record:channelList')")
    @GetMapping("/channel/list")
    @ResponseBody
    public TableDataInfo queryChannelList(int pageNum, int pageSize,
                                          @RequestParam(required = false) Integer planId,
                                          @RequestParam(required = false) String query,
                                          @RequestParam(required = false) Integer channelType,
                                          @RequestParam(required = false) Boolean online,
                                          @RequestParam(required = false) Boolean hasLink) {

        Assert.notNull(planId, "录制计划ID不可为NULL");
        if (org.springframework.util.ObjectUtils.isEmpty(query)) {
            query = null;
        }
        startPage();
        List<CommonGBChannel> list = recordPlanService.queryChannelList(pageNum, pageSize, query, channelType, online, planId, hasLink);
        return getDataTable(list);
    }

    /**
     * 更新录制计划
     *
     * @param plan 计划
     */
    @PreAuthorize("@ss.hasPermi('wvp:record:edit')")
    @ResponseBody
    @PostMapping("/update")
    public AjaxResult update(@RequestBody RecordPlan plan) {
        if (plan == null || plan.getId() == 0) {
            throw new ControllerException(ErrorCode.ERROR400);
        }
        recordPlanService.update(plan);
        return success();
    }

    /**
     * 删除录制计划
     *
     * @param planId 计划ID
     */
    @PreAuthorize("@ss.hasPermi('wvp:record:delete')")
    @ResponseBody
    @DeleteMapping("/delete/{planId}")
    public AjaxResult delete(@PathVariable Integer planId) {
        if (planId == null) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "计划IDID不可为NULL");
        }
        recordPlanService.delete(planId);
        return success();
    }

}
