package com.ruoyi.wvp.jt1078.proc.factory;

import com.ruoyi.wvp.jt1078.annotation.MsgId;
import com.ruoyi.wvp.jt1078.proc.request.Re;
import com.ruoyi.wvp.jt1078.util.ClassUtil;
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author QingtaiJiang
 * @date 2023/4/27 18:29
 * @email qingtaij@163.com
 */
@Slf4j
public class CodecFactory {

    private static Map<String, Class<?>> protocolHash;

    public static void init() {
        protocolHash = new HashMap<>();
        List<Class<?>> classList = ClassUtil.getClassList("com.genersoft.iot.vmp.jt1078.proc", MsgId.class);
        for (Class<?> handlerClass : classList) {
            String id = handlerClass.getAnnotation(MsgId.class).id();
            protocolHash.put(id, handlerClass);
        }
        if (log.isDebugEnabled()) {
            log.debug("消息ID缓存表 protocolHash:{}", protocolHash);
        }
    }

    public static Re getHandler(String msgId) {
        Class<?> aClass = protocolHash.get(msgId);
        Object bean = ClassUtil.getBean(aClass);
        if (bean instanceof Re) {
            return (Re) bean;
        }
        return null;
    }
}
