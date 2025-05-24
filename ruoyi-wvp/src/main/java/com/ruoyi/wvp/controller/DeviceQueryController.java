package com.ruoyi.wvp.controller;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.wvp.conf.DynamicTask;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.ChangeAudio;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.bean.DeviceChannel;
import com.ruoyi.wvp.gb28181.bean.SyncStatus;
import com.ruoyi.wvp.gb28181.service.IDeviceChannelService;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.service.IInviteStreamService;
import com.ruoyi.wvp.gb28181.task.ISubscribeTask;
import com.ruoyi.wvp.gb28181.task.impl.CatalogSubscribeTask;
import com.ruoyi.wvp.gb28181.task.impl.MobilePositionSubscribeTask;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.gb28181.transmit.cmd.ISIPCommander;
import com.ruoyi.common.enums.ErrorCode;
import com.ruoyi.wvp.vmanager.bean.WVPResult;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.sip.InvalidArgumentException;
import javax.sip.SipException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.text.ParseException;
import java.util.*;

/**
 * 国标设备查询
 */
@SuppressWarnings("rawtypes")
@Slf4j
@RestController
@RequestMapping("/api/device/query")
public class DeviceQueryController extends BaseController {

    @Autowired
    private IDeviceChannelService deviceChannelService;

    @Autowired
    private IInviteStreamService inviteStreamService;

    @Autowired
    private ISIPCommander cmder;

    @Autowired
    private DeferredResultHolder resultHolder;

    @Autowired
    private IDeviceService deviceService;

    @Autowired
    private DynamicTask dynamicTask;

    /**
     * 使用ID查询国标设备
     *
     * @param deviceId 设备国标编号
     * @return 国标设备
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:query')")
    @GetMapping("/devices/{deviceId}")
    public AjaxResult devices(@PathVariable String deviceId) {
        return success(deviceService.getDeviceByDeviceId(deviceId));
    }

    /**
     * 查询全部国标设备
     *
     * @param device 设备
     * @return 国标列表
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:list')")
    @GetMapping("/deviceList")
    public AjaxResult deviceList(Device device) {
        List<Device> list = deviceService.getAll(device);
        return success(list);
    }

    /**
     * 分页查询国标设备
     *
     * @param device 设备
     * @return 分页国标列表
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:list')")
    @GetMapping("/devices")
    public TableDataInfo devices(Device device) {
        startPage();
        List<Device> list = deviceService.getAll(device);
        return getDataTable(list);
    }

    /**
     * 分页查询通道数
     *
     * @param deviceId    设备国标编号
     * @param pageNum     当前页
     * @param pageSize    每页查询数量
     * @param online      是否在线
     * @param channelType 设备/子目录-> false/true
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:channels')")
    @GetMapping("/devices/channels")
    public TableDataInfo channels(String deviceId, int pageNum, int pageSize, @RequestParam(required = false) String query, @RequestParam(required = false) Boolean online, @RequestParam(required = false) Boolean channelType) {
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        List<DeviceChannel> list = deviceChannelService.queryChannelsByDeviceId(deviceId, query, channelType, online, pageNum, pageSize);
        return getDataTable(list);
    }

    /**
     * 同步设备通道
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:sync')")
    @PostMapping("/devices/{deviceId}/sync")
    public AjaxResult devicesSync(@PathVariable String deviceId) {
        if (log.isDebugEnabled()) {
            log.debug("设备通道信息同步API调用，deviceId：" + deviceId);
        }
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        boolean status = deviceService.isSyncRunning(deviceId);
        // 已存在则返回进度
        if (deviceService.isSyncRunning(deviceId)) {
            SyncStatus channelSyncStatus = deviceService.getChannelSyncStatus(deviceId);
            if (channelSyncStatus.getErrorMsg() != null) {
                return new AjaxResult(ErrorCode.ERROR100.getCode(), channelSyncStatus.getErrorMsg());
            } else if (channelSyncStatus.getTotal() == null || channelSyncStatus.getTotal() == 0) {
                return AjaxResult.success("等待通道信息...");
            } else {
                return AjaxResult.success("等待通道信息...", channelSyncStatus);
            }
        }
        deviceService.sync(device);
        return new AjaxResult(0, "开始同步");
    }

    /**
     * 移除设备
     *
     * @param deviceId 设备id
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:remove')")
    @DeleteMapping("/devices/{deviceId}/delete")
    public AjaxResult delete(@PathVariable String deviceId) {
        if (log.isDebugEnabled()) {
            log.debug("设备信息删除API调用，deviceId：" + deviceId);
        }
        // 清除redis记录
        boolean isSuccess = deviceService.delete(deviceId);
        if (isSuccess) {
            inviteStreamService.clearInviteInfo(deviceId);
            // 停止此设备的订阅更新
            Set<String> allKeys = dynamicTask.getAllKeys();
            for (String key : allKeys) {
                if (key.startsWith(deviceId)) {
                    Runnable runnable = dynamicTask.get(key);
                    if (runnable instanceof ISubscribeTask) {
                        ISubscribeTask subscribeTask = (ISubscribeTask) runnable;
                        subscribeTask.stop(null);
                    }
                    dynamicTask.stop(key);
                }
            }
            JSONObject json = new JSONObject();
            json.put("deviceId", deviceId);
            return success(json.toString());
        } else {
            log.warn("设备信息删除API调用失败！");
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "设备信息删除API调用失败！");
        }
    }

    /**
     * 分页查询子目录通道
     *
     * @param deviceId    通道id
     * @param channelId   通道id
     * @param page        当前页
     * @param count       每页条数
     * @param query       查询内容
     * @param online      是否在线
     * @param channelType 通道类型
     * @return 子通道列表
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:channels')")
    @GetMapping("/sub_channels/channels")
    public TableDataInfo subChannels(String deviceId, String channelId, int page, int count, @RequestParam(required = false) String query, @RequestParam(required = false) Boolean online, @RequestParam(required = false) Boolean channelType) {
        DeviceChannel deviceChannel = deviceChannelService.getOne(deviceId, channelId);
        if (deviceChannel == null) {
            return getDataTable(new ArrayList<>());
        }
        startPage();
        List<DeviceChannel> list = deviceChannelService.getSubChannels(deviceChannel.getDataDeviceId(), channelId, query, channelType, online, page, count);
        return getDataTable(list);
    }

    /**
     * 修改通道音频
     *
     * @param changeAudio 音频切换
     */
    @PostMapping("/channel/audio")
    public AjaxResult changeAudio(@RequestBody ChangeAudio changeAudio) {
        Assert.notNull(changeAudio.getChannelId(), "通道的数据库ID不可为NULL");
        Assert.notNull(changeAudio.getAudio(), "开启/关闭音频不可为NULL");
        deviceChannelService.changeAudio(changeAudio.getChannelId(), changeAudio.getAudio());
        return success();
    }

    /**
     * 修改通道码流
     *
     * @param channel
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:channelStreamIdentification')")
    @PostMapping("/channel/stream/identification/update/")
    public AjaxResult updateChannelStreamIdentification(@RequestBody DeviceChannel channel) {
        deviceChannelService.updateChannelStreamIdentification(channel);
        return success();
    }

    /**
     * 修改数据流传输模式
     *
     * @param deviceId   设备id
     * @param streamMode 数据流传输模式 UDP（udp传输），TCP-ACTIVE（tcp主动模式），TCP-PASSIVE（tcp被动模式）
     * @return
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:updateTransport')")
    @PostMapping("/transport/{deviceId}/{streamMode}")
    public AjaxResult updateTransport(@PathVariable String deviceId, @PathVariable String streamMode) {
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        device.setStreamMode(streamMode);
        deviceService.updateCustomDevice(device);
        return success();
    }

    /**
     * 添加设备信息
     *
     * @param device 设备信息
     * @return
     */
    @PostMapping("/device/add/")
    public void addDevice(@RequestBody Device device) {
        if (device == null || device.getDeviceId() == null) {
            throw new ControllerException(ErrorCode.ERROR400);
        }

        // 查看deviceId是否存在
        boolean exist = deviceService.isExist(device.getDeviceId());
        if (exist) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "设备编号已存在");
        }
        deviceService.addDevice(device);
    }

    /**
     * 更新设备信息
     *
     * @param device 设备信息
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:edit')")
    @PostMapping("/device/update/")
    public AjaxResult updateDevice(@RequestBody Device device) {
        if (device == null || device.getDeviceId() == null || device.getId() <= 0) {
            throw new ControllerException(ErrorCode.ERROR400);
        }
        deviceService.updateCustomDevice(device);
        return success();
    }

    /**
     * 设备状态查询请求API接口
     *
     * @param deviceId 设备id
     */
    @GetMapping("/devices/{deviceId}/status")
    public DeferredResult<ResponseEntity<String>> deviceStatusApi(@PathVariable String deviceId) {
        if (log.isDebugEnabled()) {
            log.debug("设备状态查询API调用");
        }
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        String uuid = UUID.randomUUID().toString();
        String key = DeferredResultHolder.CALLBACK_CMD_DEVICESTATUS + deviceId;
        DeferredResult<ResponseEntity<String>> result = new DeferredResult<ResponseEntity<String>>(2 * 1000L);
        if (device == null) {
            result.setResult(new ResponseEntity(String.format("设备%s不存在", deviceId), HttpStatus.OK));
            return result;
        }
        try {
            cmder.deviceStatusQuery(device, event -> {
                RequestMessage msg = new RequestMessage();
                msg.setId(uuid);
                msg.setKey(key);
                msg.setData(String.format("获取设备状态失败，错误码： %s, %s", event.statusCode, event.msg));
                resultHolder.invokeResult(msg);
            });
        } catch (InvalidArgumentException | SipException | ParseException e) {
            log.error("[命令发送失败] 获取设备状态: {}", e.getMessage());
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " + e.getMessage());
        }
        result.onTimeout(() -> {
            log.warn(String.format("获取设备状态超时"));
            // 释放rtpserver
            RequestMessage msg = new RequestMessage();
            msg.setId(uuid);
            msg.setKey(key);
            msg.setData("Timeout. Device did not response to this command.");
            resultHolder.invokeResult(msg);
        });
        resultHolder.put(DeferredResultHolder.CALLBACK_CMD_DEVICESTATUS + deviceId, uuid, result);
        return result;
    }

    /**
     * 设备报警查询请求API接口
     *
     * @param deviceId      设备id
     * @param startPriority 报警起始级别（可选）
     * @param endPriority   报警终止级别（可选）
     * @param alarmMethod   报警方式条件（可选）
     * @param alarmType     报警类型
     * @param startTime     报警发生起始时间（可选）
     * @param endTime       报警发生终止时间（可选）
     * @return true = 命令发送成功
     */
    @GetMapping("/alarm/{deviceId}")
    public DeferredResult<ResponseEntity<String>> alarmApi(@PathVariable String deviceId, @RequestParam(required = false) String startPriority, @RequestParam(required = false) String endPriority, @RequestParam(required = false) String alarmMethod, @RequestParam(required = false) String alarmType, @RequestParam(required = false) String startTime, @RequestParam(required = false) String endTime) {
        if (log.isDebugEnabled()) {
            log.debug("设备报警查询API调用");
        }
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        String key = DeferredResultHolder.CALLBACK_CMD_ALARM + deviceId;
        String uuid = UUID.randomUUID().toString();
        try {
            cmder.alarmInfoQuery(device, startPriority, endPriority, alarmMethod, alarmType, startTime, endTime, event -> {
                RequestMessage msg = new RequestMessage();
                msg.setId(uuid);
                msg.setKey(key);
                msg.setData(String.format("设备报警查询失败，错误码： %s, %s", event.statusCode, event.msg));
                resultHolder.invokeResult(msg);
            });
        } catch (InvalidArgumentException | SipException | ParseException e) {
            log.error("[命令发送失败] 设备报警查询: {}", e.getMessage());
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " + e.getMessage());
        }
        DeferredResult<ResponseEntity<String>> result = new DeferredResult<ResponseEntity<String>>(3 * 1000L);
        result.onTimeout(() -> {
            log.warn(String.format("设备报警查询超时"));
            // 释放rtpserver
            RequestMessage msg = new RequestMessage();
            msg.setId(uuid);
            msg.setKey(key);
            msg.setData("设备报警查询超时");
            resultHolder.invokeResult(msg);
        });
        resultHolder.put(DeferredResultHolder.CALLBACK_CMD_ALARM + deviceId, uuid, result);
        return result;
    }

    /**
     * 同步进度查询
     *
     * @param deviceId
     * @return
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:sync')")
    @PostMapping("/{deviceId}/sync_status")
    public AjaxResult getSyncStatus(@PathVariable String deviceId) {
        SyncStatus channelSyncStatus = deviceService.getChannelSyncStatus(deviceId);
        if (channelSyncStatus == null) {
            return new AjaxResult(ErrorCode.ERROR100.getCode(), "同步不存在");
        } else if (channelSyncStatus.getErrorMsg() != null) {
            return new AjaxResult(ErrorCode.ERROR100.getCode(), channelSyncStatus.getErrorMsg());
        } else if (channelSyncStatus.getTotal() == null || channelSyncStatus.getTotal() == 0) {
            return AjaxResult.success("等待通道信息...");
        } else {
            return AjaxResult.success(ErrorCode.SUCCESS.getMsg(), channelSyncStatus);
        }
    }

    /**
     * 获取订阅信息
     *
     * @param deviceId 设备国标编号
     * @return
     */
    @GetMapping("/{deviceId}/subscribe_info")
    public WVPResult<Map<String, Integer>> getSubscribeInfo(@PathVariable String deviceId) {
        Set<String> allKeys = dynamicTask.getAllKeys();
        Map<String, Integer> dialogStateMap = new HashMap<>();
        for (String key : allKeys) {
            if (key.startsWith(deviceId)) {
                ISubscribeTask subscribeTask = (ISubscribeTask) dynamicTask.get(key);
                if (subscribeTask instanceof CatalogSubscribeTask) {
                    dialogStateMap.put("catalog", 1);
                } else if (subscribeTask instanceof MobilePositionSubscribeTask) {
                    dialogStateMap.put("mobilePosition", 1);
                }
            }
        }
        WVPResult<Map<String, Integer>> wvpResult = new WVPResult<>();
        wvpResult.setCode(0);
        wvpResult.setData(dialogStateMap);
        return wvpResult;
    }

    /**
     * 请求截图
     *
     * @param resp      响应数据
     * @param deviceId  设备国标编号
     * @param channelId 通道国标编号
     * @param mark      标识
     */
    @Anonymous
    @GetMapping("/snap/{deviceId}/{channelId}")
    public void getSnap(HttpServletResponse resp, @PathVariable String deviceId, @PathVariable String channelId, @RequestParam(required = false) String mark) {
        try {
            final InputStream in = Files.newInputStream(new File("snap" + File.separator + deviceId + "_" + channelId + (mark == null ? ".jpg" : ("_" + mark + ".jpg"))).toPath());
            resp.setContentType(MediaType.IMAGE_PNG_VALUE);
            ServletOutputStream outputStream = resp.getOutputStream();
            IOUtils.copy(in, resp.getOutputStream());
            in.close();
            outputStream.close();
        } catch (IOException e) {
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        }
    }

    /**
     * 国标通道编辑时的数据回显
     *
     * @param id 通道的Id
     * @return
     */
    @GetMapping("/channel/raw")
    public DeviceChannel getRawChannel(int id) {
        return deviceChannelService.getRawChannel(id);
    }

    /**
     * 开启/关闭目录订阅
     *
     * @param id    通道的Id
     * @param cycle 订阅周期
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:subscribeCatalog')")
    @PostMapping("/subscribe/catalog/{id}/{cycle}")
    public AjaxResult subscribeCatalog(@PathVariable int id, @PathVariable int cycle) {
        deviceService.subscribeCatalog(id, cycle);
        return success();
    }

    /**
     * 开启/关闭移动位置订阅
     *
     * @param id       通道的Id
     * @param cycle    订阅周期
     * @param interval 报送间隔
     */
    @PreAuthorize("@ss.hasPermi('wvp:device:subscribeMobilePosition')")
    @PostMapping("/subscribe/mobile-position/{id}/{cycle}/{interval}")
    public void subscribeMobilePosition(@PathVariable int id, @PathVariable int cycle, @PathVariable int interval) {
        deviceService.subscribeMobilePosition(id, cycle, interval);
    }
}
