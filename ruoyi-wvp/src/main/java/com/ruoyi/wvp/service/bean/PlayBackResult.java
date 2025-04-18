package com.ruoyi.wvp.service.bean;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.wvp.gb28181.event.SipSubscribe;
import com.ruoyi.wvp.media.bean.MediaServer;

import java.util.EventObject;


/**
 * @author lin
 */
public class PlayBackResult<T> {
    private int code;

    private String msg;
    private T data;
    private MediaServer mediaServerItem;
    private JSONObject response;
    private SipSubscribe.EventResult<EventObject> event;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public MediaServer getMediaServerItem() {
        return mediaServerItem;
    }

    public void setMediaServerItem(MediaServer mediaServerItem) {
        this.mediaServerItem = mediaServerItem;
    }

    public JSONObject getResponse() {
        return response;
    }

    public void setResponse(JSONObject response) {
        this.response = response;
    }

    public SipSubscribe.EventResult<EventObject> getEvent() {
        return event;
    }

    public void setEvent(SipSubscribe.EventResult<EventObject> event) {
        this.event = event;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
