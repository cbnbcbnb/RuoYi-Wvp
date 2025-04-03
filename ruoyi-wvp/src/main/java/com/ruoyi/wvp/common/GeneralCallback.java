package com.ruoyi.wvp.common;

public interface GeneralCallback<T>{
    void run(int code, String msg, T data);
}
