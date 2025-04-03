package com.ruoyi.wvp.gb28181.task;

import com.ruoyi.wvp.common.CommonCallback;

/**
 * @author lin
 */
public interface ISubscribeTask extends Runnable{
    void stop(CommonCallback<Boolean> callback);
}
