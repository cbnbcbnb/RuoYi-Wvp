package com.ruoyi.common.exception;

import com.ruoyi.common.enums.ErrorCode;

/**
 * 自定义异常，controller出现错误时直接抛出异常由全局异常捕获并返回结果
 */
public final class ControllerException extends RuntimeException{

    private static final long serialVersionUID = 1L;

    /**
     * 错误码
     */
    private Integer code;

    /**
     * 错误提示
     */
    private String message;


    /**
     * 错误明细，内部调试错误
     *
     * 和 {@link CommonResult#getDetailMessage()} 一致的设计
     */
    private String detailMessage;

    public ControllerException(int code, String msg) {
        this.code = code;
        this.message = msg;
    }
    public ControllerException(ErrorCode errorCode) {
        this.code = errorCode.getCode();
        this.message = errorCode.getMsg();
    }

    public String getDetailMessage()
    {
        return detailMessage;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
