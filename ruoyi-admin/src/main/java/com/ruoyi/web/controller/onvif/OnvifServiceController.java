package com.ruoyi.web.controller.onvif;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.onvif.domain.FetchMainAndSubStreamUris;
import com.ruoyi.onvif.domain.bo.FetchMainAndSubStreamUrisBo;
import com.ruoyi.onvif.utils.onvifUtil;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * onvif 控制器
 *
 * @Author: 陈江灿
 * @CreateTime: 2025-04-09
 */
@RestController
@RequestMapping("/onvif/service")
public class OnvifServiceController extends BaseController {

    /**
     * 获取onvif设备信息
     * @return
     */
    @PreAuthorize("@ss.hasPermi('onvif:service:getInfo')")
    @GetMapping("/getInfo")
    public AjaxResult getOnvifDeviceInfo(FetchMainAndSubStreamUrisBo bo) {
        FetchMainAndSubStreamUris fetchMainAndSubStreamUris = onvifUtil.fetchMainAndSubStreamUris(bo);
        return success(fetchMainAndSubStreamUris);
    }
}
