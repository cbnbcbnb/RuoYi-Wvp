package com.ruoyi.wvp.gb28181.controller;


import com.github.pagehelper.util.StringUtil;
import com.ruoyi.wvp.conf.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.bean.MobilePosition;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.gb28181.transmit.cmd.impl.SIPCommander;
import com.ruoyi.wvp.service.IMobilePositionService;
import com.ruoyi.wvp.vmanager.bean.ErrorCode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import javax.sip.InvalidArgumentException;
import javax.sip.SipException;
import java.text.ParseException;
import java.util.List;
import java.util.UUID;

/**
 *  位置信息管理
 */
@Tag(name  = "位置信息管理")
@Slf4j
@RestController
@RequestMapping("/api/position")
public class MobilePositionController {

    @Autowired
    private IMobilePositionService mobilePositionService;

	@Autowired
	private SIPCommander cmder;

	@Autowired
	private DeferredResultHolder resultHolder;

	@Autowired
	private IDeviceService deviceService;


    /**
     * 查询历史轨迹
     * @param deviceId 设备ID
     * @param start 开始时间
     * @param end 结束时间
     * @return
     */
    @Parameter(name = "deviceId", description = "设备国标编号", required = true)
    @Parameter(name = "channelId", description = "通道国标编号")
    @Parameter(name = "start", description = "开始时间")
    @Parameter(name = "end", description = "结束时间")
    @GetMapping("/history/{deviceId}")
    public List<MobilePosition> positions(@PathVariable String deviceId,
                                          @RequestParam(required = false) String channelId,
                                          @RequestParam(required = false) String start,
                                          @RequestParam(required = false) String end) {

        if (StringUtil.isEmpty(start)) {
            start = null;
        }
        if (StringUtil.isEmpty(end)) {
            end = null;
        }
        return mobilePositionService.queryMobilePositions(deviceId, channelId, start, end);
    }

    /**
     *  查询设备最新位置
     * @param deviceId 设备ID
     * @return
     */
    @Parameter(name = "deviceId", description = "设备国标编号", required = true)
    @GetMapping("/latest/{deviceId}")
    public MobilePosition latestPosition(@PathVariable String deviceId) {
        return mobilePositionService.queryLatestPosition(deviceId);
    }

    /**
     *  获取移动位置信息
     * @param deviceId 设备ID
     * @return
     */
    @Parameter(name = "deviceId", description = "设备国标编号", required = true)
    @GetMapping("/realtime/{deviceId}")
    public DeferredResult<MobilePosition> realTimePosition(@PathVariable String deviceId) {
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        String uuid = UUID.randomUUID().toString();
        String key = DeferredResultHolder.CALLBACK_CMD_MOBILE_POSITION + deviceId;
        try {
            cmder.mobilePostitionQuery(device, event -> {
                RequestMessage msg = new RequestMessage();
                msg.setId(uuid);
                msg.setKey(key);
                msg.setData(String.format("获取移动位置信息失败，错误码： %s, %s", event.statusCode, event.msg));
                resultHolder.invokeResult(msg);
            });
        } catch (InvalidArgumentException | SipException | ParseException e) {
            log.error("[命令发送失败] 获取移动位置信息: {}", e.getMessage());
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " + e.getMessage());
        }
        DeferredResult<MobilePosition> result = new DeferredResult<MobilePosition>(5*1000L);
		result.onTimeout(()->{
			log.warn(String.format("获取移动位置信息超时"));
			// 释放rtpserver
			RequestMessage msg = new RequestMessage();
            msg.setId(uuid);
            msg.setKey(key);
			msg.setData("Timeout");
			resultHolder.invokeResult(msg);
		});
        resultHolder.put(key, uuid, result);
        return result;
    }

    /**
     * 订阅位置信息
     * @param deviceId 设备ID
     * @param expires 订阅超时时间
     * @param interval 上报时间间隔
     * @return true = 命令发送成功
     */
    @Parameter(name = "deviceId", description = "设备国标编号", required = true)
    @Parameter(name = "expires", description = "订阅超时时间", required = true)
    @Parameter(name = "interval", description = "上报时间间隔", required = true)
    @GetMapping("/subscribe/{deviceId}")
    public void positionSubscribe(@PathVariable String deviceId,
                                                    @RequestParam String expires,
                                                    @RequestParam String interval) {

        if (StringUtil.isEmpty(interval)) {
            interval = "5";
        }
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        device.setSubscribeCycleForMobilePosition(Integer.parseInt(expires));
        device.setMobilePositionSubmissionInterval(Integer.parseInt(interval));
        deviceService.updateCustomDevice(device);
    }
}
