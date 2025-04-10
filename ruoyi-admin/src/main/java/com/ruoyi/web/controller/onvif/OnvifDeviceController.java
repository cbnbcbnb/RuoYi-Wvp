package com.ruoyi.web.controller.onvif;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.onvif.domain.OnvifDevice;
import com.ruoyi.onvif.service.IOnvifDeviceService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * onvif 设备Controller
 *
 * @author 陈江灿
 * @date 2025-04-10
 */
@RestController
@RequestMapping("/onvif/device")
public class OnvifDeviceController extends BaseController {
    @Autowired
    private IOnvifDeviceService onvifDeviceService;

    /**
     * 查询onvif 设备列表
     */
    @PreAuthorize("@ss.hasPermi('onvif:device:list')")
    @GetMapping("/list")
    public TableDataInfo list(OnvifDevice onvifDevice) {
        startPage();
        List<OnvifDevice> list = onvifDeviceService.selectOnvifDeviceList(onvifDevice);
        return getDataTable(list);
    }

    /**
     * 导出onvif 设备列表
     */
    @PreAuthorize("@ss.hasPermi('onvif:device:export')")
    @Log(title = "onvif 设备", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, OnvifDevice onvifDevice) {
        List<OnvifDevice> list = onvifDeviceService.selectOnvifDeviceList(onvifDevice);
        ExcelUtil<OnvifDevice> util = new ExcelUtil<OnvifDevice>(OnvifDevice.class);
        util.exportExcel(response, list, "onvif 设备数据");
    }

    /**
     * 获取onvif 设备详细信息
     */
    @PreAuthorize("@ss.hasPermi('onvif:device:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(onvifDeviceService.selectOnvifDeviceById(id));
    }

    /**
     * 新增onvif 设备
     */
    @PreAuthorize("@ss.hasPermi('onvif:device:add')")
    @Log(title = "onvif 设备", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody OnvifDevice onvifDevice) {
        return toAjax(onvifDeviceService.insertOnvifDevice(onvifDevice));
    }

    /**
     * 修改onvif 设备
     */
    @PreAuthorize("@ss.hasPermi('onvif:device:edit')")
    @Log(title = "onvif 设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody OnvifDevice onvifDevice) {
        return toAjax(onvifDeviceService.updateOnvifDevice(onvifDevice));
    }

    /**
     * 删除onvif 设备
     */
    @PreAuthorize("@ss.hasPermi('onvif:device:remove')")
    @Log(title = "onvif 设备", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(onvifDeviceService.deleteOnvifDeviceByIds(ids));
    }
}
