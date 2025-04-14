package com.ruoyi.wvp.vmanager.recordPlan;

import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.wvp.conf.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.CommonGBChannel;
import com.ruoyi.wvp.gb28181.service.IDeviceChannelService;
import com.ruoyi.wvp.service.IRecordPlanService;
import com.ruoyi.wvp.service.bean.RecordPlan;
import com.ruoyi.wvp.vmanager.bean.ErrorCode;
import com.ruoyi.wvp.vmanager.recordPlan.bean.RecordPlanParam;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Tag(name = "录制计划")
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
    @ResponseBody
    @PostMapping("/add")
    public AjaxResult add(@RequestBody RecordPlan plan) {
        if (plan.getPlanItemList() == null || plan.getPlanItemList().isEmpty()) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "添加录制计划时，录制计划不可为空");
        }
        recordPlanService.add(plan);
        return success();
    }

    @ResponseBody
    @PostMapping("/link")
    @Parameter(name = "param", description = "通道关联录制计划", required = true)
    public void link(@RequestBody RecordPlanParam param) {
        if (param.getAllLink() != null) {
            if (param.getAllLink()) {
                recordPlanService.linkAll(param.getPlanId());
            } else {
                recordPlanService.cleanAll(param.getPlanId());
            }
            return;
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

    @Parameter(name = "page", description = "当前页", required = true)
    @Parameter(name = "count", description = "每页条数", required = true)
    @Parameter(name = "planId", description = "录制计划ID")
    @Parameter(name = "channelType", description = "通道类型， 0：国标设备，1：推流设备，2：拉流代理")
    @Parameter(name = "query", description = "查询内容")
    @Parameter(name = "online", description = "是否在线")
    @Parameter(name = "hasLink", description = "是否已经关联")
    @GetMapping("/channel/list")
    @ResponseBody
    public PageInfo<CommonGBChannel> queryChannelList(int page, int count,
                                                      @RequestParam(required = false) Integer planId,
                                                      @RequestParam(required = false) String query,
                                                      @RequestParam(required = false) Integer channelType,
                                                      @RequestParam(required = false) Boolean online,
                                                      @RequestParam(required = false) Boolean hasLink) {

        Assert.notNull(planId, "录制计划ID不可为NULL");
        if (org.springframework.util.ObjectUtils.isEmpty(query)) {
            query = null;
        }

        return recordPlanService.queryChannelList(page, count, query, channelType, online, planId, hasLink);
    }

    /**
     * 更新录制计划
     *
     * @param plan 计划
     */
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
