package com.ruoyi.wvp.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.service.IPTZService;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.gb28181.transmit.cmd.impl.SIPCommander;
import com.ruoyi.common.enums.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;

import javax.sip.InvalidArgumentException;
import javax.sip.SipException;
import java.text.ParseException;
import java.util.UUID;

/**
 * 前端设备控制
 */
@Slf4j
@RestController
@RequestMapping("/api/front-end")
public class PtzController extends BaseController {

	@Autowired
	private SIPCommander cmder;

	@Autowired
	private IDeviceService deviceService;

	@Autowired
	private IPTZService ptzService;

	@Autowired
	private DeferredResultHolder resultHolder;

	/**
	 * 云台控制
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param cmdCode 指令码(对应国标文档指令格式中的字节4)
	 * @param parameter1 数据一(对应国标文档指令格式中的字节5, 范围0-255)
	 * @param parameter2 数据二(对应国标文档指令格式中的字节6, 范围0-255)
	 * @param combindCode2 组合码二(对应国标文档指令格式中的字节7, 范围0-15)
	 */
	@GetMapping("/common/{deviceId}/{channelId}")
	public void frontEndCommand(@PathVariable String deviceId,@PathVariable String channelId,Integer cmdCode, Integer parameter1, Integer parameter2, Integer combindCode2){

		if (log.isDebugEnabled()) {
			log.debug(String.format("设备云台控制 API调用，deviceId：%s ，channelId：%s ，cmdCode：%d parameter1：%d parameter2：%d",deviceId, channelId, cmdCode, parameter1, parameter2));
		}

		if (parameter1 == null || parameter1 < 0 || parameter1 > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "parameter1 为 0-255的数字");
		}
		if (parameter2 == null || parameter2 < 0 || parameter2 > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "parameter2 为 0-255的数字");
		}
		if (combindCode2 == null || combindCode2 < 0 || combindCode2 > 15) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "combindCode2 为 0-15的数字");
		}

		Device device = deviceService.getDeviceByDeviceId(deviceId);

		Assert.notNull(device, "设备[" + deviceId + "]不存在");

		ptzService.frontEndCommand(device, channelId, cmdCode, parameter1, parameter2, combindCode2);
	}

	/**
	 * 云台控制
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param command 控制指令,允许值: left, right, up, down, upleft, upright, downleft, downright, zoomin, zoomout, stop
	 * @param horizonSpeed 水平速度(0-255)
	 * @param verticalSpeed 垂直速度(0-255)
	 * @param zoomSpeed 缩放速度(0-15)
	 */
	@GetMapping("/ptz/{deviceId}/{channelId}")
	public void ptz(@PathVariable String deviceId,@PathVariable String channelId, String command, Integer horizonSpeed, Integer verticalSpeed, Integer zoomSpeed){

		if (log.isDebugEnabled()) {
			log.debug(String.format("设备云台控制 API调用，deviceId：%s ，channelId：%s ，command：%s ，horizonSpeed：%d ，verticalSpeed：%d ，zoomSpeed：%d",deviceId, channelId, command, horizonSpeed, verticalSpeed, zoomSpeed));
		}
		if (horizonSpeed == null) {
			horizonSpeed = 100;
		}else if (horizonSpeed < 0 || horizonSpeed > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "horizonSpeed 为 0-255的数字");
		}
		if (verticalSpeed == null) {
			verticalSpeed = 100;
		}else if (verticalSpeed < 0 || verticalSpeed > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "verticalSpeed 为 0-255的数字");
		}
		if (zoomSpeed == null) {
			zoomSpeed = 16;
		}else if (zoomSpeed < 0 || zoomSpeed > 15) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "zoomSpeed 为 0-15的数字");
		}

		int cmdCode = 0;
		switch (command){
			case "left":
				cmdCode = 2;
				break;
			case "right":
				cmdCode = 1;
				break;
			case "up":
				cmdCode = 8;
				break;
			case "down":
				cmdCode = 4;
				break;
			case "upleft":
				cmdCode = 10;
				break;
			case "upright":
				cmdCode = 9;
				break;
			case "downleft":
				cmdCode = 6;
				break;
			case "downright":
				cmdCode = 5;
				break;
			case "zoomin":
				cmdCode = 16;
				break;
			case "zoomout":
				cmdCode = 32;
				break;
			case "stop":
				horizonSpeed = 0;
				verticalSpeed = 0;
				zoomSpeed = 0;
				break;
			default:
				break;
		}
		frontEndCommand(deviceId, channelId, cmdCode, horizonSpeed, verticalSpeed, zoomSpeed);
	}

	/**
	 * 设备光圈控制
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param command 控制指令,允许值: in, out, stop
	 * @param speed 光圈速度(0-255)
	 */
	@GetMapping("/fi/iris/{deviceId}/{channelId}")
	public void iris(@PathVariable String deviceId,@PathVariable String channelId, String command, Integer speed){

		if (log.isDebugEnabled()) {
			log.debug("设备光圈控制 API调用，deviceId：{} ，channelId：{} ，command：{} ，speed：{} ",deviceId, channelId, command, speed);
		}

		if (speed == null) {
			speed = 100;
		}else if (speed < 0 || speed > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "speed 为 0-255的数字");
		}

		int cmdCode = 0x40;
		switch (command){
			case "in":
				cmdCode = 0x44;
				break;
			case "out":
				cmdCode = 0x48;
				break;
			case "stop":
				speed = 0;
				break;
			default:
				break;
		}
		frontEndCommand(deviceId, channelId, cmdCode, 0, speed, 0);
	}

	/**
	 * 设备聚焦控制
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param command 控制指令,允许值: near, far, stop
	 * @param speed 聚焦速度(0-255)
	 */
	@GetMapping("/fi/focus/{deviceId}/{channelId}")
	public void focus(@PathVariable String deviceId,@PathVariable String channelId, String command, Integer speed){

		if (log.isDebugEnabled()) {
			log.debug("设备聚焦控制 API调用，deviceId：{} ，channelId：{} ，command：{} ，speed：{} ",deviceId, channelId, command, speed);
		}

		if (speed == null) {
			speed = 100;
		}else if (speed < 0 || speed > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "speed 为 0-255的数字");
		}

		int cmdCode = 0x40;
		switch (command){
			case "near":
				cmdCode = 0x42;
				break;
			case "far":
				cmdCode = 0x41;
				break;
			case "stop":
				speed = 0;
				break;
			default:
				break;
		}
		frontEndCommand(deviceId, channelId, cmdCode, speed, 0, 0);
	}

	/**
	 * 设备变倍控制
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @return
	 */
	@GetMapping("/preset/query/{deviceId}/{channelId}")
	public DeferredResult<String> queryPreset(@PathVariable String deviceId, @PathVariable String channelId) {
		if (log.isDebugEnabled()) {
			log.debug("设备预置位查询API调用");
		}
		Device device = deviceService.getDeviceByDeviceId(deviceId);
		String uuid =  UUID.randomUUID().toString();
		String key =  DeferredResultHolder.CALLBACK_CMD_PRESETQUERY + (ObjectUtils.isEmpty(channelId) ? deviceId : channelId);
		DeferredResult<String> result = new DeferredResult<String> (3 * 1000L);
		result.onTimeout(()->{
			log.warn(String.format("获取设备预置位超时"));
			// 释放rtpserver
			RequestMessage msg = new RequestMessage();
			msg.setId(uuid);
			msg.setKey(key);
			msg.setData("获取设备预置位超时");
			resultHolder.invokeResult(msg);
		});
		if (resultHolder.exist(key, null)) {
			return result;
		}
		resultHolder.put(key, uuid, result);
		try {
			cmder.presetQuery(device, channelId, event -> {
				RequestMessage msg = new RequestMessage();
				msg.setId(uuid);
				msg.setKey(key);
				msg.setData(String.format("获取设备预置位失败，错误码： %s, %s", event.statusCode, event.msg));
				resultHolder.invokeResult(msg);
			});
		} catch (InvalidArgumentException | SipException | ParseException e) {
			log.error("[命令发送失败] 获取设备预置位: {}", e.getMessage());
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " + e.getMessage());
		}
		return result;
	}

	/**
	 * 设备预置位添加
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param presetId 预置位编号(1-255)
	 */
	@GetMapping("/preset/add/{deviceId}/{channelId}")
	public void addPreset(@PathVariable String deviceId, @PathVariable String channelId, Integer presetId) {
		if (presetId == null || presetId < 1 || presetId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "预置位编号必须为1-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x81, 1, presetId, 0);
	}

	/**
	 * 设备预置位调用
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param presetId 预置位编号(1-255)
	 */
	@GetMapping("/preset/call/{deviceId}/{channelId}")
	public void callPreset(@PathVariable String deviceId, @PathVariable String channelId, Integer presetId) {
		if (presetId == null || presetId < 1 || presetId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "预置位编号必须为1-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x82, 1, presetId, 0);
	}

	/**
	 * 设备预置位删除
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param presetId 预置位编号(1-255)
	 */
	@GetMapping("/preset/delete/{deviceId}/{channelId}")
	public void deletePreset(@PathVariable String deviceId, @PathVariable String channelId, Integer presetId) {
		if (presetId == null || presetId < 1 || presetId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "预置位编号必须为1-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x83, 1, presetId, 0);
	}

	/**
	 * 设备巡航点添加
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param cruiseId 巡航组号(0-255)
	 * @param presetId 预置位编号(1-255)
	 */
	@GetMapping("/cruise/point/add/{deviceId}/{channelId}")
	public void addCruisePoint(@PathVariable String deviceId, @PathVariable String channelId, Integer cruiseId, Integer presetId) {
		if (presetId == null || cruiseId == null || presetId < 1 || presetId > 255 || cruiseId < 0 || cruiseId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "编号必须为1-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x84, cruiseId, presetId, 0);
	}

	/**
	 * 设备巡航点删除
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param cruiseId 巡航组号(1-255)
	 * @param presetId 预置位编号(0-255, 为0时删除整个巡航)
	 */
	@GetMapping("/cruise/point/delete/{deviceId}/{channelId}")
	public void deleteCruisePoint(@PathVariable String deviceId, @PathVariable String channelId, Integer cruiseId, Integer presetId) {
		if (presetId == null || presetId < 0 || presetId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "预置位编号必须为0-255之间的数字, 为0时删除整个巡航");
		}
		if (cruiseId == null || cruiseId < 0 || cruiseId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "巡航组号必须为0-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x85, cruiseId, presetId, 0);
	}

	/**
	 * 设备巡航速度设置
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param cruiseId 巡航组号(0-255)
	 * @param speed 巡航速度(1-4095)
	 */
	@GetMapping("/cruise/speed/{deviceId}/{channelId}")
	public void setCruiseSpeed(@PathVariable String deviceId, @PathVariable String channelId, Integer cruiseId, Integer speed) {
		if (cruiseId == null || cruiseId < 0 || cruiseId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "巡航组号必须为0-255之间的数字");
		}
		if (speed == null || speed < 1 || speed > 4095) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "巡航速度必须为1-4095之间的数字");
		}
		int parameter2 = speed & 0xFF;
		int combindCode2 =  speed >> 8;
		frontEndCommand(deviceId, channelId, 0x86, cruiseId, parameter2, combindCode2);
	}

	/**
	 * 设备巡航停留时间设置
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param cruiseId 巡航组号
	 * @param time 巡航停留时间(1-4095)
	 */
	@GetMapping("/cruise/time/{deviceId}/{channelId}")
	public void setCruiseTime(@PathVariable String deviceId, @PathVariable String channelId, Integer cruiseId, Integer time) {
		if (cruiseId == null || cruiseId < 0 || cruiseId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "巡航组号必须为0-255之间的数字");
		}
		if (time == null || time < 1 || time > 4095) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "巡航停留时间必须为1-4095之间的数字");
		}
		int parameter2 = time & 0xFF;
		int combindCode2 =  time >> 8;
		frontEndCommand(deviceId, channelId, 0x87, cruiseId, parameter2, combindCode2);
	}

	/**
	 * 设备巡航启动
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param cruiseId 巡航组号
	 */
	@GetMapping("/cruise/start/{deviceId}/{channelId}")
	public void startCruise(@PathVariable String deviceId, @PathVariable String channelId, Integer cruiseId) {
		if (cruiseId == null || cruiseId < 0 || cruiseId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "巡航组号必须为0-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x88, cruiseId, 0, 0);
	}

	/**
	 * 设备巡航停止
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param cruiseId 巡航组号
	 */
	@GetMapping("/cruise/stop/{deviceId}/{channelId}")
	public void stopCruise(@PathVariable String deviceId, @PathVariable String channelId, Integer cruiseId) {
		if (cruiseId == null || cruiseId < 0 || cruiseId > 255) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "巡航组号必须为0-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0, 0, 0, 0);
	}

	/**
	 * 设备扫描启动
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param scanId 扫描组号(0-255)
	 */
	@GetMapping("/scan/start/{deviceId}/{channelId}")
	public void startScan(@PathVariable String deviceId, @PathVariable String channelId, Integer scanId) {
		if (scanId == null || scanId < 0 || scanId > 255 ) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "扫描组号必须为0-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x89, scanId, 0, 0);
	}

	/**
	 * 设备扫描停止
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param scanId 扫描组号(0-255)
	 */
	@GetMapping("/scan/stop/{deviceId}/{channelId}")
	public void stopScan(@PathVariable String deviceId, @PathVariable String channelId, Integer scanId) {
		if (scanId == null || scanId < 0 || scanId > 255 ) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "扫描组号必须为0-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0, 0, 0, 0);
	}

	/**
	 * 设备扫描上
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param scanId 扫描组号(0-255)
	 */
	@GetMapping("/scan/set/left/{deviceId}/{channelId}")
	public void setScanLeft(@PathVariable String deviceId, @PathVariable String channelId, Integer scanId) {
		if (scanId == null || scanId < 0 || scanId > 255 ) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "扫描组号必须为0-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x89, scanId, 1, 0);
	}

	/**
	 * 设备扫描下
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param scanId 扫描组号(0-255)
	 */
	@GetMapping("/scan/set/right/{deviceId}/{channelId}")
	public void setScanRight(@PathVariable String deviceId, @PathVariable String channelId, Integer scanId) {
		if (scanId == null || scanId < 0 || scanId > 255 ) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "扫描组号必须为0-255之间的数字");
		}
		frontEndCommand(deviceId, channelId, 0x89, scanId, 2, 0);
	}


	/**
	 * 设备扫描左
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param scanId 扫描组号(0-255)
	 * @param speed 自动扫描速度(1-4095)
	 */
	@GetMapping("/scan/set/speed/{deviceId}/{channelId}")
	public void setScanSpeed(@PathVariable String deviceId, @PathVariable String channelId, Integer scanId, Integer speed) {
		if (scanId == null || scanId < 0 || scanId > 255 ) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "扫描组号必须为0-255之间的数字");
		}
		if (speed == null || speed < 1 || speed > 4095) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "自动扫描速度必须为1-4095之间的数字");
		}
		int parameter2 = speed & 0xFF;
		int combindCode2 =  speed >> 8;
		frontEndCommand(deviceId, channelId, 0x8A, scanId, parameter2, combindCode2);
	}

	/**
	 * 设备雨刷控制
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param command 控制指令,允许值: on, off
	 */
	@GetMapping("/wiper/{deviceId}/{channelId}")
	public void wiper(@PathVariable String deviceId,@PathVariable String channelId, String command){

		if (log.isDebugEnabled()) {
			log.debug("辅助开关控制指令-雨刷控制 API调用，deviceId：{} ，channelId：{} ，command：{}",deviceId, channelId, command);
		}

		int cmdCode = 0;
		switch (command){
			case "on":
				cmdCode = 0x8c;
				break;
			case "off":
				cmdCode = 0x8d;
				break;
			default:
				break;
		}
		frontEndCommand(deviceId, channelId, cmdCode, 1, 0, 0);
	}

	/**
	 * 设备雨刷控制
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param command 控制指令,允许值: on, off
	 * @param switchId 开关编号
	 */
	@GetMapping("/auxiliary/{deviceId}/{channelId}")
	public void auxiliarySwitch(@PathVariable String deviceId,@PathVariable String channelId, String command, Integer switchId){

		if (log.isDebugEnabled()) {
			log.debug("辅助开关控制指令-雨刷控制 API调用，deviceId：{} ，channelId：{} ，command：{}, switchId: {}",deviceId, channelId, command, switchId);
		}

		int cmdCode = 0;
		switch (command){
			case "on":
				cmdCode = 0x8c;
				break;
			case "off":
				cmdCode = 0x8d;
				break;
			default:
				break;
		}
		frontEndCommand(deviceId, channelId, cmdCode, switchId, 0, 0);
	}
}
