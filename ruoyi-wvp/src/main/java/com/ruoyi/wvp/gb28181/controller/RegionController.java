package com.ruoyi.wvp.gb28181.controller;

import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.wvp.conf.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Region;
import com.ruoyi.wvp.gb28181.bean.RegionTree;
import com.ruoyi.wvp.gb28181.service.IRegionService;
import com.ruoyi.wvp.vmanager.bean.ErrorCode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "区域管理")
@RestController
@RequestMapping("/api/region")
public class RegionController extends BaseController {

    private final static Logger logger = LoggerFactory.getLogger(RegionController.class);

    @Autowired
    private IRegionService regionService;

    /**
     * 添加区域
     *
     * @param region
     */
    @ResponseBody
    @PostMapping("/add")
    public AjaxResult add(@RequestBody Region region) {
        regionService.add(region);
        return success();
    }

    @Operation(summary = "查询区域")
    @Parameter(name = "query", description = "要搜索的内容", required = true)
    @Parameter(name = "page", description = "当前页", required = true)
    @Parameter(name = "count", description = "每页查询数量", required = true)
    @ResponseBody
    @GetMapping("/page/list")
    public PageInfo<Region> query(
            @RequestParam(required = false) String query,
            @RequestParam(required = true) int page,
            @RequestParam(required = true) int count
    ) {
        return regionService.query(query, page, count);
    }

    /**
     * 查询区域
     *
     * @param query 要搜索的内容
     * @param parent 父节点
     * @param hasChannel  是否包含通道
     * @return
     */
    @ResponseBody
    @GetMapping("/tree/list")
    public AjaxResult queryForTree(
            @RequestParam(required = false) String query,
            @RequestParam(required = false) Integer parent,
            @RequestParam(required = false) Boolean hasChannel
    ) {
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        return success(regionService.queryForTree(query, parent, hasChannel));
    }

    /**
     * 更新区域
     *
     * @param region
     */
    @ResponseBody
    @PostMapping("/update")
    public AjaxResult update(@RequestBody Region region) {
        regionService.update(region);
        return success();
    }

    /**
     * 删除区域
     *
     * @param id 区域ID
     */
    @ResponseBody
    @DeleteMapping("/delete/{id}")
    public AjaxResult delete(@PathVariable Integer id) {
        Assert.notNull(id, "区域ID需要存在");
        boolean result = regionService.deleteByDeviceId(id);
        if (!result) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "移除失败");
        }
        return success();
    }

    @Operation(summary = "根据区域Id查询区域")
    @Parameter(name = "regionDeviceId", description = "行政区划节点编号", required = true)
    @ResponseBody
    @GetMapping("/one")
    public Region queryRegionByDeviceId(
            @RequestParam(required = true) String regionDeviceId
    ) {
        if (ObjectUtils.isEmpty(regionDeviceId.trim())) {
            throw new ControllerException(ErrorCode.ERROR400);
        }
        return regionService.queryRegionByDeviceId(regionDeviceId);
    }

    /**
     * 获取所属的行政区划下的行政区划
     *
     * @param parent
     * @return
     */
    @ResponseBody
    @GetMapping("/base/child/list")
    public AjaxResult getAllChild(@RequestParam(required = false) String parent) {
        if (ObjectUtils.isEmpty(parent)) {
            parent = null;
        }
        return success(regionService.getAllChild(parent));
    }

    @Operation(summary = "获取所属的行政区划下的行政区划")
    @Parameter(name = "deviceId", description = "当前的行政区划", required = false)
    @ResponseBody
    @GetMapping("/path")
    public List<Region> getPath(String deviceId) {
        return regionService.getPath(deviceId);
    }

    @Operation(summary = "从通道中同步行政区划")
    @ResponseBody
    @GetMapping("/sync")
    public void sync() {
        regionService.syncFromChannel();
    }
}
