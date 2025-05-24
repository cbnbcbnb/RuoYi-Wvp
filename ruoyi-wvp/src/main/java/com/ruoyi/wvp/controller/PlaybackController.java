package com.ruoyi.wvp.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.wvp.common.InviteInfo;
import com.ruoyi.wvp.common.InviteSessionType;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.conf.UserSetting;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.bean.DeviceChannel;
import com.ruoyi.wvp.gb28181.service.IDeviceChannelService;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.service.IInviteStreamService;
import com.ruoyi.wvp.gb28181.service.IPlayService;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.gb28181.transmit.cmd.impl.SIPCommander;
import com.ruoyi.wvp.service.bean.InviteErrorCode;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.StreamContent;
import com.ruoyi.wvp.vmanager.bean.WVPResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;

import javax.servlet.http.HttpServletRequest;
import javax.sip.InvalidArgumentException;
import javax.sip.SipException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.util.UUID;

/**
 * 视频回放
 *
 * @author lin
 */
@Slf4j
@RestController
@RequestMapping("/api/playback")
public class PlaybackController extends BaseController {

	@Autowired
	private SIPCommander cmder;

	@Autowired
	private IInviteStreamService inviteStreamService;

	@Autowired
	private IPlayService playService;

	@Autowired
	private DeferredResultHolder resultHolder;

	@Autowired
	private UserSetting userSetting;

	@Autowired
	private IDeviceService deviceService;

	@Autowired
	private IDeviceChannelService channelService;

	/**
	 * 开始回放
	 *
	 * @param request
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@PreAuthorize("@ss.hasPermi('gb:playback:start')")
	@GetMapping("/start")
	public DeferredResult<WVPResult<StreamContent>> start(HttpServletRequest request, String deviceId,  String channelId,
														  String startTime, String endTime) {

		if (log.isDebugEnabled()) {
			log.debug(String.format("设备回放 API调用，deviceId：%s ，channelId：%s", deviceId, channelId));
		}

		String uuid = UUID.randomUUID().toString();
		String key = DeferredResultHolder.CALLBACK_CMD_PLAYBACK + deviceId + channelId;
		DeferredResult<WVPResult<StreamContent>> result = new DeferredResult<>(userSetting.getPlayTimeout().longValue());
		resultHolder.put(key, uuid, result);

		RequestMessage requestMessage = new RequestMessage();
		requestMessage.setKey(key);
		requestMessage.setId(uuid);
		Device device = deviceService.getDeviceByDeviceId(deviceId);
		if (device == null) {
			log.warn("[录像回放] 未找到设备 deviceId: {},channelId:{}", deviceId, channelId);
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到设备：" + deviceId);
		}

		DeviceChannel channel = channelService.getOne(deviceId, channelId);
		if (channel == null) {
			log.warn("[录像回放] 未找到通道 deviceId: {},channelId:{}", deviceId, channelId);
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "未找到通道：" + channelId);
		}
		playService.playBack(device, channel, startTime, endTime,
				(code, msg, data)->{

					WVPResult<StreamContent> wvpResult = new WVPResult<>();
					if (code == InviteErrorCode.SUCCESS.getCode()) {
						wvpResult.setCode(ErrorCode.SUCCESS.getCode());
						wvpResult.setMsg(ErrorCode.SUCCESS.getMsg());

						if (data != null) {
							StreamInfo streamInfo = (StreamInfo)data;
							if (userSetting.getUseSourceIpAsStreamIp()) {
								streamInfo=streamInfo.clone();//深拷贝
								String host;
								try {
									URL url=new URL(request.getRequestURL().toString());
									host=url.getHost();
								} catch (MalformedURLException e) {
									host=request.getLocalAddr();
								}
								streamInfo.channgeStreamIp(host);
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
	 * 停止回放
	 *
	 * @param deviceId 设备国标编号
	 * @param channelId 通道国标编号
	 * @param stream 流ID
	 */
	@GetMapping("/stop/{deviceId}/{channelId}/{stream}")
	public AjaxResult playStop(
			@PathVariable String deviceId,
			@PathVariable String channelId,
			@PathVariable String stream) {
		if (ObjectUtils.isEmpty(deviceId) || ObjectUtils.isEmpty(channelId) || ObjectUtils.isEmpty(stream)) {
			throw new ControllerException(ErrorCode.ERROR400);
		}
		Device device = deviceService.getDeviceByDeviceId(deviceId);
		if (device == null) {
			throw new ControllerException(ErrorCode.ERROR400.getCode(), "设备：" + deviceId + " 未找到");
		}
		DeviceChannel deviceChannel = channelService.getOneForSource(deviceId, channelId);
		if (deviceChannel == null) {
			throw new ControllerException(ErrorCode.ERROR400.getCode(), "通道：" + deviceChannel + " 未找到");
		}
		playService.stop(InviteSessionType.PLAYBACK, device, deviceChannel, stream);
		return success();
	}


	/**
	 * 暂停回放
	 *
	 * @param streamId 回放流ID
	 */
	@GetMapping("/pause/{streamId}")
	public void playPause(@PathVariable String streamId) {
		log.info("playPause: "+streamId);

		try {
			playService.pauseRtp(streamId);
		} catch (ServiceException e) {
			throw new ControllerException(ErrorCode.ERROR400.getCode(), e.getMessage());
		} catch (InvalidArgumentException | ParseException | SipException e) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), e.getMessage());
		}
	}

	/**
	 * 恢复回放
	 *
	 * @param streamId 回放流ID
	 */
	@GetMapping("/resume/{streamId}")
	public void playResume(@PathVariable String streamId) {
		log.info("playResume: "+streamId);
		try {
			playService.resumeRtp(streamId);
		} catch (ServiceException e) {
			throw new ControllerException(ErrorCode.ERROR400.getCode(), e.getMessage());
		} catch (InvalidArgumentException | ParseException | SipException e) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), e.getMessage());
		}
	}

	/**
	 * 拖动回放
	 *
	 * @param streamId 回放流ID
	 * @param seekTime 拖动偏移量，单位s
	 */
	@GetMapping("/seek/{streamId}/{seekTime}")
	public void playSeek(@PathVariable String streamId, @PathVariable long seekTime) {
		log.info("playSeek: "+streamId+", "+seekTime);
		InviteInfo inviteInfo = inviteStreamService.getInviteInfoByStream(InviteSessionType.PLAYBACK, streamId);

		if (null == inviteInfo || inviteInfo.getStreamInfo() == null) {
			log.warn("streamId不存在!");
			throw new ControllerException(ErrorCode.ERROR400.getCode(), "streamId不存在");
		}
		Device device = deviceService.getDeviceByDeviceId(inviteInfo.getDeviceId());
		DeviceChannel channel = channelService.getOneById(inviteInfo.getChannelId());
		try {
			cmder.playSeekCmd(device, channel, inviteInfo.getStreamInfo(), seekTime);
		} catch (InvalidArgumentException | ParseException | SipException e) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), e.getMessage());
		}
	}

	/**
	 * 回放倍速
	 *
	 * @param streamId 回放流ID
	 * @param speed 倍速0.25 0.5 1、2、4
	 */
	@GetMapping("/speed/{streamId}/{speed}")
	public void playSpeed(@PathVariable String streamId, @PathVariable Double speed) {
		log.info("playSpeed: "+streamId+", "+speed);
		InviteInfo inviteInfo = inviteStreamService.getInviteInfoByStream(InviteSessionType.PLAYBACK, streamId);

		if (null == inviteInfo || inviteInfo.getStreamInfo() == null) {
			log.warn("streamId不存在!");
			throw new ControllerException(ErrorCode.ERROR400.getCode(), "streamId不存在");
		}
		if(speed != 0.25 && speed != 0.5 && speed != 1 && speed != 2.0 && speed != 4.0) {
			log.warn("不支持的speed： " + speed);
			throw new ControllerException(ErrorCode.ERROR100.getCode(), "不支持的speed（0.25 0.5 1、2、4）");
		}
		Device device = deviceService.getDeviceByDeviceId(inviteInfo.getDeviceId());
		DeviceChannel channel = channelService.getOneById(inviteInfo.getChannelId());
		try {
			cmder.playSpeedCmd(device, channel, inviteInfo.getStreamInfo(), speed);
		} catch (InvalidArgumentException | ParseException | SipException e) {
			throw new ControllerException(ErrorCode.ERROR100.getCode(), e.getMessage());
		}
	}
}
