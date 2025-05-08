package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.SysWork;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 工作台
 *
 * @author fengcheng
 */
@RestController
@RequestMapping("/system/work")
public class SysWorkController extends BaseController {

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 获取工作台列表
     */
    @PreAuthorize("@ss.hasPermi('system:work:list')")
    @GetMapping("/list")
    public AjaxResult list() {
        return success(redisTemplate.opsForValue().get(CacheConstants.SYS_WORK_LIST));
    }

    /**
     * 修改工作台
     */
    @PreAuthorize("@ss.hasPermi('system:work:edit')")
    @Log(title = "工作台", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysWork work) {
        redisTemplate.opsForValue().set(CacheConstants.SYS_WORK_LIST, work);
        return success();
    }
}
