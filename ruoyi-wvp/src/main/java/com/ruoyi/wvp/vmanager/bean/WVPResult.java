package com.ruoyi.wvp.vmanager.bean;

import com.ruoyi.common.enums.ErrorCode;

/**
 * 统一返回结果
 * @param <T>
 */
public class WVPResult<T> implements Cloneable{

    public WVPResult() {
    }

    public WVPResult(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }


    /**
     * 错误码，0为成功
     */
    private int code;

    /**
     * 描述，错误时描述错误原因
     */
    private String msg;

    /**
     * 数据
     */
    private T data;


    public static <T> WVPResult<T> success(T t, String msg) {
        return new WVPResult<>(ErrorCode.SUCCESS.getCode(), msg, t);
    }

    public static WVPResult success() {
        return new WVPResult<>(ErrorCode.SUCCESS.getCode(), ErrorCode.SUCCESS.getMsg(), null);
    }

    public static <T> WVPResult<T> success(T t) {
        return success(t, ErrorCode.SUCCESS.getMsg());
    }

    public static <T> WVPResult<T> fail(int code, String msg) {
        return new WVPResult<>(code, msg, null);
    }

    public static <T> WVPResult<T> fail(ErrorCode errorCode) {
        return fail(errorCode.getCode(), errorCode.getMsg());
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}
