package com.ruoyi.wvp.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.common.exception.SsrcTransactionNotFoundException;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.bean.DeviceChannel;
import com.ruoyi.wvp.gb28181.service.IDeviceChannelService;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.service.IPlayService;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.gb28181.transmit.cmd.impl.SIPCommander;
import com.ruoyi.wvp.media.bean.RecordInfo;
import com.ruoyi.wvp.service.bean.InviteErrorCode;
import com.ruoyi.wvp.utils.DateUtil;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.StreamContent;
import com.ruoyi.wvp.vmanager.bean.WVPResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;

import javax.servlet.http.HttpServletRequest;
import javax.sip.InvalidArgumentException;
import javax.sip.SipException;
import java.text.ParseException;
import java.util.UUID;

/**
 * 国标录像
 */
@Slf4j
@RestController
@RequestMapping("/api/gb_record")
public class GBRecordController extends BaseController {

	@Autowired
	private SIPCommander cmder;

	@Autowired
	private DeferredResultHolder resultHolder;

	@Autowired
	private IPlayService playService;

	@Autowired
	private IDeviceChannelService channelService;

	@Autowired
	private IDeviceService deviceService;

	@Autowired
	private UserSetting userSetting;

	/**
	 * 录像信息查询
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@PreAuthorize("@ss.hasPermi('gb:record:query')")
	@GetMapping("/query")
	public DeferredResult<WVPResult<RecordInfo>> recordinfo( String deviceId, String channelId, String startTime, String endTime, String type){

		if (log.isDebugEnabled()) {
			log.debug(String.format("录像信息查询 API调用，deviceId：%s ，startTime：%s， endTime：%s",deviceId, startTime, endTime));
		}
		DeferredResult<WVPResult<RecordInfo>> result = new DeferredResult<>();
		if (!DateUtil.verification(startTime, DateUtil.formatter)){
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "startTime格式为" + DateUtil.PATTERN);
		}
		if (!DateUtil.verification(endTime, DateUtil.formatter)){
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "endTime格式为" + DateUtil.PATTERN);
		}

		Device device = deviceService.getDeviceByDeviceId(deviceId);
		// 指定超时时间 1分钟30秒
		String uuid = UUID.randomUUID().toString();
		int sn  =  (int)((Math.random()*9+1)*100000);
		String key = DeferredResultHolder.CALLBACK_CMD_RECORDINFO + deviceId + sn;
		RequestMessage msg = new RequestMessage();
		msg.setId(uuid);
		msg.setKey(key);
		try {
			cmder.recordInfoQuery(device, channelId, startTime, endTime, sn, null, type, null, (eventResult -> {
				WVPResult<RecordInfo> wvpResult = new WVPResult<>();
				wvpResult.setCode(ErrorCode.ERROR100.getCode());
				wvpResult.setMsg("查询录像失败, status: " +  eventResult.statusCode + ", message: " + eventResult.msg);
				msg.setData(wvpResult);
				resultHolder.invokeResult(msg);
			}));
		} catch (InvalidArgumentException | SipException | ParseException e) {
			log.error("[命令发送失败] 查询录像: {}", e.getMessage());
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " +  e.getMessage());
		}

		// 录像查询以channelId作为deviceId查询
		resultHolder.put(key, uuid, result);
		result.onTimeout(()->{
			msg.setData("timeout");
			WVPResult<RecordInfo> wvpResult = new WVPResult<>();
			wvpResult.setCode(ErrorCode.ERROR100.getCode());
			wvpResult.setMsg("timeout");
			msg.setData(wvpResult);
			resultHolder.invokeResult(msg);
		});
        return result;
	}


	/**
	 * 录像下载
	 *
	 * @param request
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @param downloadSpeed 下载倍速
	 * @return
	 */
	@PreAuthorize("@ss.hasPermi('gb:record:download')")
	@GetMapping("/download/start")
	public DeferredResult<WVPResult<StreamContent>> download(HttpServletRequest request,  String deviceId, String channelId,
															 String startTime, String endTime, String downloadSpeed) {

		if (log.isDebugEnabled()) {
			log.debug(String.format("历史媒体下载 API调用，deviceId：%s，channelId：%s，downloadSpeed：%s", deviceId, channelId, downloadSpeed));
		}

		String uuid = UUID.randomUUID().toString();
		String key = DeferredResultHolder.CALLBACK_CMD_DOWNLOAD + deviceId + channelId;
		DeferredResult<WVPResult<StreamContent>> result = new DeferredResult<>(30000L);
		resultHolder.put(key, uuid, result);
		RequestMessage requestMessage = new RequestMessage();
		requestMessage.setId(uuid);
		requestMessage.setKey(key);

		Device device = deviceService.getDeviceByDeviceId(deviceId);
		if (device == null) {
			log.warn("[开始历史媒体下载] 未找到设备 deviceId: {},channelId:{}", deviceId, channelId);
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到设备：" + deviceId);
		}

		DeviceChannel channel = channelService.getOne(deviceId, channelId);
		if (channel == null) {
			log.warn("[开始历史媒体下载] 未找到通道 deviceId: {},channelId:{}", deviceId, channelId);
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到通道：" + channelId);
		}
		playService.download(device, channel, startTime, endTime, Integer.parseInt(downloadSpeed),
		(code, msg, data)->{

			WVPResult<StreamContent> wvpResult = new WVPResult<>();
			if (code == InviteErrorCode.SUCCESS.getCode()) {
				wvpResult.setCode(ErrorCode.SUCCESS.getCode());
				wvpResult.setMsg(ErrorCode.SUCCESS.getMsg());

				if (data != null) {
					StreamInfo streamInfo = (StreamInfo)data;
					if (userSetting.getUseSourceIpAsStreamIp()) {
						streamInfo.channgeStreamIp(request.getLocalAddr());
					}
					wvpResult.setData(new StreamContent(streamInfo));
				}
			}else {
				wvpResult.setCode(code);
				wvpResult.setMsg(msg);
			}
			requestMessage.setData(wvpResult);
			resultHolder.invokeResult(requestMessage);
		});

		return result;
	}

	/**
	 * 停止录像下载
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param stream 流ID
	 */
	@GetMapping("/download/stop/{deviceId}/{channelId}/{stream}")
	public void playStop(@PathVariable String deviceId, @PathVariable String channelId, @PathVariable String stream) {

		if (log.isDebugEnabled()) {
			log.debug(String.format("设备历史媒体下载停止 API调用，deviceId/channelId：%s_%s", deviceId, channelId));
		}

		if (deviceId == null || channelId == null) {
			throw new ControllerException(ErrorCode.ERROR400);
		}

		Device device = deviceService.getDeviceByDeviceId(deviceId);
		if (device == null) {
			throw new ControllerException(ErrorCode.ERROR400.getCode(), "设备：" + deviceId + "未找到");
		}

		try {
			cmder.streamByeCmd(device, channelId, "rtp", stream, null, null);
		} catch (InvalidArgumentException | ParseException | SipException | SsrcTransactionNotFoundException e) {
			log.warn("[停止历史媒体下载]停止历史媒体下载，发送BYE失败 {}", e.getMessage());
		}
	}

	/**
	 * 获取历史媒体下载进度
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param stream 流ID
	 * @return
	 */
	@GetMapping("/download/progress/{deviceId}/{channelId}/{stream}")
	public AjaxResult getProgress(@PathVariable String deviceId, @PathVariable String channelId, @PathVariable String stream) {
		Device device = deviceService.getDeviceByDeviceId(deviceId);
		if (device == null) {
			log.warn("[获取历史媒体下载进度] 未找到设备 deviceId: {},channelId:{}", deviceId, channelId);
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到设备：" + deviceId);
		}

		DeviceChannel channel = channelService.getOne(deviceId, channelId);
		if (channel == null) {
			log.warn("[获取历史媒体下载进度] 未找到通道 deviceId: {},channelId:{}", deviceId, channelId);
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到通道：" + channelId);
		}
		StreamInfo downLoadInfo = playService.getDownLoadInfo(device, channel, stream);
		if (downLoadInfo == null) {
			throw new ControllerException(ErrorCode.ERROR404);
		}
		return success(new StreamContent(downLoadInfo));
	}
}
