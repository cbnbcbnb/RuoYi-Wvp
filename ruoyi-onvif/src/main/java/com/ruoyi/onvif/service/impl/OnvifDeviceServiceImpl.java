package com.ruoyi.onvif.service.impl;

import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.onvif.mapper.OnvifDeviceMapper;
import com.ruoyi.onvif.domain.OnvifDevice;
import com.ruoyi.onvif.service.IOnvifDeviceService;

/**
 * onvif 设备Service业务层处理
 *
 * @author 陈江灿
 * @date 2025-04-10
 */
@Service
public class OnvifDeviceServiceImpl implements IOnvifDeviceService {
    @Autowired
    private OnvifDeviceMapper onvifDeviceMapper;

    /**
     * 查询onvif 设备
     *
     * @param id onvif 设备主键
     * @return onvif 设备
     */
    @Override
    public OnvifDevice selectOnvifDeviceById(Long id) {
        return onvifDeviceMapper.selectOnvifDeviceById(id);
    }

    /**
     * 查询onvif 设备列表
     *
     * @param onvifDevice onvif 设备
     * @return onvif 设备
     */
    @Override
    public List<OnvifDevice> selectOnvifDeviceList(OnvifDevice onvifDevice) {
        return onvifDeviceMapper.selectOnvifDeviceList(onvifDevice);
    }

    /**
     * 新增onvif 设备
     *
     * @param onvifDevice onvif 设备
     * @return 结果
     */
    @Override
    public int insertOnvifDevice(OnvifDevice onvifDevice) {
        try{
            if (onvifDevice.getStreamUris() != null) {
                onvifDevice.setStreamUris(new ObjectMapper().writeValueAsString(onvifDevice.getStreamUris()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        onvifDevice.setCreateTime(DateUtils.getNowDate());
        return onvifDeviceMapper.insertOnvifDevice(onvifDevice);
    }

    /**
     * 修改onvif 设备
     *
     * @param onvifDevice onvif 设备
     * @return 结果
     */
    @Override
    public int updateOnvifDevice(OnvifDevice onvifDevice) {
        try{
            if (onvifDevice.getStreamUris() != null) {
                onvifDevice.setStreamUris(new ObjectMapper().writeValueAsString(onvifDevice.getStreamUris()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        onvifDevice.setUpdateTime(DateUtils.getNowDate());
        return onvifDeviceMapper.updateOnvifDevice(onvifDevice);
    }

    /**
     * 批量删除onvif 设备
     *
     * @param ids 需要删除的onvif 设备主键
     * @return 结果
     */
    @Override
    public int deleteOnvifDeviceByIds(Long[] ids) {
        return onvifDeviceMapper.deleteOnvifDeviceByIds(ids);
    }

    /**
     * 删除onvif 设备信息
     *
     * @param id onvif 设备主键
     * @return 结果
     */
    @Override
    public int deleteOnvifDeviceById(Long id) {
        return onvifDeviceMapper.deleteOnvifDeviceById(id);
    }
}
