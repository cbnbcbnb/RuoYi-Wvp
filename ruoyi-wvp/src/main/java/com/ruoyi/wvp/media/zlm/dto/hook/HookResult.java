package com.ruoyi.wvp.media.zlm.dto.hook;

public class HookResult {

    private int code;
    private String msg;


    public HookResult() {
    }

    public HookResult(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public static HookResult SUCCESS(){
        return new HookResult(0, "success");
    }

    public static HookResultForOnPublish Fail(){
        return new HookResultForOnPublish(-1, "fail");
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
}
