package com.ruoyi.wvp.controller;

import com.github.pagehelper.PageInfo;
import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.bean.DeviceAlarm;
import com.ruoyi.wvp.gb28181.bean.Platform;
import com.ruoyi.wvp.gb28181.service.IDeviceAlarmService;
import com.ruoyi.wvp.gb28181.service.IDeviceService;
import com.ruoyi.wvp.gb28181.service.IPlatformService;
import com.ruoyi.wvp.gb28181.transmit.cmd.ISIPCommander;
import com.ruoyi.wvp.gb28181.transmit.cmd.ISIPCommanderForPlatform;
import com.ruoyi.wvp.utils.DateUtil;
import com.ruoyi.common.enums.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.sip.InvalidArgumentException;
import javax.sip.SipException;
import java.text.ParseException;
import java.util.Arrays;
import java.util.List;

/**
 * 报警信息管理
 */
@Slf4j
@RestController
@RequestMapping("/api/alarm")
public class AlarmController {

    @Autowired
    private IDeviceAlarmService deviceAlarmService;

    @Autowired
    private ISIPCommander commander;

    @Autowired
    private ISIPCommanderForPlatform commanderForPlatform;

    @Autowired
    private IPlatformService platformService;

    @Autowired
    private IDeviceService deviceService;


    /**
     *  删除报警
     *
     * @param id 报警id
     * @param deviceIds 多个设备id,逗号分隔
     * @param time 结束时间(这个时间之前的报警会被删除)
     * @return
     */
    @DeleteMapping("/delete")
    public Integer delete(
            @RequestParam(required = false) Integer id,
            @RequestParam(required = false) String deviceIds,
            @RequestParam(required = false) String time
    ) {
        if (ObjectUtils.isEmpty(id)) {
            id = null;
        }
        if (ObjectUtils.isEmpty(deviceIds)) {
            deviceIds = null;
        }

        if (ObjectUtils.isEmpty(time)) {
            time = null;
        }else if (!DateUtil.verification(time, DateUtil.formatter) ){
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "time格式为" + DateUtil.PATTERN);
        }
        List<String> deviceIdList = null;
        if (deviceIds != null) {
            String[] deviceIdArray = deviceIds.split(",");
            deviceIdList = Arrays.asList(deviceIdArray);
        }

        return deviceAlarmService.clearAlarmBeforeTime(id, deviceIdList, time);
    }

    /**
     *  测试向上级/设备发送模拟报警通知
     *
     * @param deviceId 报警id
     * @return
     */
    @GetMapping("/test/notify/alarm")
    public void delete(@RequestParam String deviceId) {
        Device device = deviceService.getDeviceByDeviceId(deviceId);
        Platform platform = platformService.queryPlatformByServerGBId(deviceId);
        DeviceAlarm deviceAlarm = new DeviceAlarm();
        deviceAlarm.setChannelId(deviceId);
        deviceAlarm.setAlarmDescription("test");
        deviceAlarm.setAlarmMethod("1");
        deviceAlarm.setAlarmPriority("1");
        deviceAlarm.setAlarmTime(DateUtil.getNow());
        deviceAlarm.setAlarmType("1");
        deviceAlarm.setLongitude(115.33333);
        deviceAlarm.setLatitude(39.33333);

        if (device != null && platform == null) {

            try {
                commander.sendAlarmMessage(device, deviceAlarm);
            } catch (InvalidArgumentException | SipException | ParseException e) {

            }
        }else if (device == null && platform != null){
            try {
                commanderForPlatform.sendAlarmMessage(platform, deviceAlarm);
            } catch (SipException | InvalidArgumentException | ParseException e) {
                log.error("[命令发送失败] 国标级联 发送BYE: {}", e.getMessage());
                throw new ControllerException(ErrorCode.ERROR100.getCode(), "命令发送失败: " +  e.getMessage());
            }
        }else {
            throw new ControllerException(ErrorCode.ERROR100.getCode(),"无法确定" + deviceId + "是平台还是设备");
        }

    }

    /**
     *  分页查询报警
     *
     * @param deviceId 设备id
     * @param page 当前页
     * @param count 每页查询数量
     * @param alarmPriority  报警级别
     * @param alarmMethod 报警方式
     * @param alarmType  报警类型
     * @param startTime  开始时间
     * @param endTime 结束时间
     * @return
     */
    @GetMapping("/all")
    public PageInfo<DeviceAlarm> getAll(
            @RequestParam int page,
            @RequestParam int count,
            @RequestParam(required = false)  String deviceId,
            @RequestParam(required = false) String alarmPriority,
            @RequestParam(required = false) String alarmMethod,
            @RequestParam(required = false) String alarmType,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime
    ) {
        if (ObjectUtils.isEmpty(alarmPriority)) {
            alarmPriority = null;
        }
        if (ObjectUtils.isEmpty(alarmMethod)) {
            alarmMethod = null;
        }
        if (ObjectUtils.isEmpty(alarmType)) {
            alarmType = null;
        }

        if (ObjectUtils.isEmpty(startTime)) {
            startTime = null;
        }else if (!DateUtil.verification(startTime, DateUtil.formatter) ){
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "startTime格式为" + DateUtil.PATTERN);
        }

        if (ObjectUtils.isEmpty(endTime)) {
            endTime = null;
        }else if (!DateUtil.verification(endTime, DateUtil.formatter) ){
            throw new ControllerException(ErrorCode.ERROR400.getCode(), "endTime格式为" + DateUtil.PATTERN);
        }

        return deviceAlarmService.getAllAlarm(page, count, deviceId, alarmPriority, alarmMethod,
                alarmType, startTime, endTime);
    }
}
