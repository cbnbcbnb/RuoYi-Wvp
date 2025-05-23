package com.ruoyi.wvp.gb28181.event.record;

import com.ruoyi.wvp.gb28181.bean.RecordInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @description: 录像查询结束事件
 * @author: pan
 * @data: 2022-02-23
 */
@Slf4j
@Component
public class RecordEndEventListener implements ApplicationListener<RecordEndEvent> {

    private Map<String, RecordEndEventHandler> handlerMap = new ConcurrentHashMap<>();

    /**
     * 事件处理接口
     */
    public interface RecordEndEventHandler{
        void  handler(RecordInfo recordInfo);
    }

    /**
     * 事件触发
     *
     * @param event
     */
    @Override
    public void onApplicationEvent(RecordEndEvent event) {
        String deviceId = event.getRecordInfo().getDeviceId();
        String channelId = event.getRecordInfo().getChannelId();
        int count = event.getRecordInfo().getCount();
        int sumNum = event.getRecordInfo().getSumNum();
        if (!handlerMap.isEmpty()) {
            RecordEndEventHandler handler = handlerMap.get(deviceId + channelId);
            log.info("录像查询事件触发, 发送订阅，deviceId：{}, channelId: {}",
                    event.getRecordInfo().getDeviceId(), event.getRecordInfo().getChannelId());
            if (handler !=null){
                handler.handler(event.getRecordInfo());
                if (count ==sumNum){
                    handlerMap.remove(deviceId + channelId);
                }
            }
        }
    }

    /**
     * 添加
     * @param device
     * @param channelId
     * @param recordEndEventHandler
     */
    public void addEndEventHandler(String device, String channelId, RecordEndEventHandler recordEndEventHandler) {
        log.info("录像查询事件添加监听，deviceId：{}, channelId: {}", device, channelId);
        handlerMap.put(device + channelId, recordEndEventHandler);
    }
    /**
     * 添加
     * @param device
     * @param channelId
     */
    public void delEndEventHandler(String device, String channelId) {
        log.info("录像查询事件移除监听，deviceId：{}, channelId: {}", device, channelId);
        handlerMap.remove(device + channelId);
    }

}
