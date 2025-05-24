package com.ruoyi.wvp.controller;

import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Region;
import com.ruoyi.wvp.gb28181.service.IRegionService;
import com.ruoyi.common.enums.ErrorCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 区域管理
 */
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
    @PreAuthorize("@ss.hasPermi('wvp:region:add')")
    @ResponseBody
    @PostMapping("/add")
    public AjaxResult add(@RequestBody Region region) {
        regionService.add(region);
        return success();
    }

    /**
     * 查询区域
     *
     * @param query 要搜索的内容
     * @param page 当前页
     * @param count 每页查询数量
     * @return
     */
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
    @PreAuthorize("@ss.hasPermi('wvp:region:list')")
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
    @PreAuthorize("@ss.hasPermi('wvp:region:edit')")
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
    @PreAuthorize("@ss.hasPermi('wvp:region:delete')")
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

    /**
     * 根据区域Id查询区域
     *
     * @param regionDeviceId 行政区划节点编号
     * @return
     */
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

    /**
     * 获取所属的行政区划下的行政区划
     *
     * @param deviceId 当前的行政区划
     * @return
     */
    @ResponseBody
    @GetMapping("/path")
    public List<Region> getPath(String deviceId) {
        return regionService.getPath(deviceId);
    }

    /**
     * 从通道中同步行政区划
     */
    @ResponseBody
    @GetMapping("/sync")
    public void sync() {
        regionService.syncFromChannel();
    }
}
