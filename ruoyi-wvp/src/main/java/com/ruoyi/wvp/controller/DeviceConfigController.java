/**
 * 设备设置命令API接口
 *
 * @author lawrencehj
 * @date 2021年2月2日
 */

package com.ruoyi.wvp.controller;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.gb28181.transmit.cmd.impl.SIPCommander;
import com.ruoyi.common.enums.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import javax.sip.InvalidArgumentException;
import javax.sip.SipException;
import java.text.ParseException;
import java.util.UUID;

/**
 * 国标设备配置
 */
@Slf4j
@RestController
@RequestMapping("/api/device/config")
public class DeviceConfigController extends BaseController {

    @Autowired
    private IDeviceService deviceService;

    @Autowired
    private SIPCommander cmder;

    @Autowired
    private DeferredResultHolder resultHolder;

    /**
     * 看守位控制命令API接口
     *
     * @param deviceId          设备ID
     * @param channelId         通道ID
     * @param name              名称
     * @param expiration        到期时间
     * @param heartBeatInterval 心跳间隔
     * @param heartBeatCount    心跳计数
     * @return
     */
    @GetMapping("/basicParam/{deviceId}")
    public DeferredResult<String> homePositionApi(@PathVariable String deviceId,
                                                  @RequestParam(required = false) String channelId,
                                                  @RequestParam(required = false) String name,
                                                  @RequestParam(required = false) String expiration,
                                                  @RequestParam(required = false) String heartBeatInterval,
                                                  @RequestParam(required = false) String heartBeatCount) {
        if (log.isDebugEnabled()) {
            log.debug("报警复位API调用");
        }
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        String uuid = UUID.randomUUID().toString();
        String key = DeferredResultHolder.CALLBACK_CMD_DEVICECONFIG + deviceId + channelId;
        try {
            cmder.deviceBasicConfigCmd(device, channelId, name, expiration, heartBeatInterval, heartBeatCount, event -> {
                RequestMessage msg = new RequestMessage();
                msg.setId(uuid);
                msg.setKey(key);
                msg.setData(String.format("设备配置操作失败，错误码： %s, %s", event.statusCode, event.msg));
                resultHolder.invokeResult(msg);
            });
        } catch (InvalidArgumentException | SipException | ParseException e) {
            log.error("[命令发送失败] 设备配置: {}", e.getMessage());
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " + e.getMessage());
        }
        DeferredResult<String> result = new DeferredResult<String>(3 * 1000L);
        result.onTimeout(() -> {
            log.warn(String.format("设备配置操作超时, 设备未返回应答指令"));
            // 释放rtpserver
            RequestMessage msg = new RequestMessage();
            msg.setId(uuid);
            msg.setKey(key);
            JSONObject json = new JSONObject();
            json.put("DeviceID", deviceId);
            json.put("Status", "Timeout");
            json.put("Description", "设备配置操作超时, 设备未返回应答指令");
            msg.setData(json); //("看守位控制操作超时, 设备未返回应答指令");
            resultHolder.invokeResult(msg);
        });
        resultHolder.put(key, uuid, result);
        return result;
    }

    /**
     * 设备配置查询请求API接口
     *
     * @param deviceId   设备ID
     * @param configType 配置类型
     * @param channelId  通道ID
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:config:cdownloadApi')")
    @GetMapping("/query/{deviceId}/{configType}")
    public DeferredResult<String> configDownloadApi(@PathVariable String deviceId,
										@PathVariable String configType,
										@RequestParam(required = false) String channelId) {
        if (log.isDebugEnabled()) {
            log.debug("设备状态查询API调用");
        }
        String key = DeferredResultHolder.CALLBACK_CMD_CONFIGDOWNLOAD + (ObjectUtils.isEmpty(channelId) ? deviceId : deviceId + channelId);
        String uuid = UUID.randomUUID().toString();
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        try {
            cmder.deviceConfigQuery(device, channelId, configType, event -> {
                RequestMessage msg = new RequestMessage();
                msg.setId(uuid);
                msg.setKey(key);
                msg.setData(String.format("获取设备配置失败，错误码： %s, %s", event.statusCode, event.msg));
                resultHolder.invokeResult(msg);
            });
        } catch (InvalidArgumentException | SipException | ParseException e) {
            log.error("[命令发送失败] 获取设备配置: {}", e.getMessage());
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " + e.getMessage());
        }
        DeferredResult<String> result = new DeferredResult<String>(3 * 1000L);
        result.onTimeout(() -> {
            log.warn(String.format("获取设备配置超时"));
            // 释放rtpserver
            RequestMessage msg = new RequestMessage();
            msg.setId(uuid);
            msg.setKey(key);
            msg.setData("Timeout. Device did not response to this command.");
            resultHolder.invokeResult(msg);
        });
        resultHolder.put(key, uuid, result);
        return result;
    }

}
