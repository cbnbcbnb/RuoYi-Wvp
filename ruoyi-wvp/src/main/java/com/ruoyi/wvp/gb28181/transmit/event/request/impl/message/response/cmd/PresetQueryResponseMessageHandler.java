package com.ruoyi.wvp.gb28181.transmit.event.request.impl.message.response.cmd;

import com.ruoyi.wvp.gb28181.bean.Device;
import com.ruoyi.wvp.gb28181.bean.Platform;
import com.ruoyi.wvp.gb28181.bean.Preset;
import com.ruoyi.wvp.gb28181.transmit.callback.DeferredResultHolder;
import com.ruoyi.wvp.gb28181.transmit.callback.RequestMessage;
import com.ruoyi.wvp.gb28181.transmit.event.request.SIPRequestProcessorParent;
import com.ruoyi.wvp.gb28181.transmit.event.request.impl.message.IMessageHandler;
import com.ruoyi.wvp.gb28181.transmit.event.request.impl.message.response.ResponseMessageHandler;
import gov.nist.javax.sip.message.SIPRequest;
import lombok.extern.slf4j.Slf4j;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sip.InvalidArgumentException;
import javax.sip.RequestEvent;
import javax.sip.SipException;
import javax.sip.message.Response;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static com.ruoyi.wvp.gb28181.utils.XmlUtil.getText;

/**
 * 设备预置位查询应答
 */
@Slf4j
@Component
public class PresetQueryResponseMessageHandler extends SIPRequestProcessorParent implements InitializingBean, IMessageHandler {

    private final String cmdType = "PresetQuery";

    @Autowired
    private ResponseMessageHandler responseMessageHandler;

    @Autowired
    private DeferredResultHolder deferredResultHolder;


    @Override
    public void afterPropertiesSet() throws Exception {
        responseMessageHandler.addHandler(cmdType, this);
    }

    @Override
    public void handForDevice(RequestEvent evt, Device device, Element element) {

        SIPRequest request = (SIPRequest) evt.getRequest();

        try {
             Element rootElement = getRootElement(evt, device.getCharset());

            if (rootElement == null) {
                log.warn("[ 设备预置位查询应答 ] content cannot be null, {}", evt.getRequest());
                try {
                    responseAck(request, Response.BAD_REQUEST);
                } catch (InvalidArgumentException | ParseException | SipException e) {
                    log.error("[命令发送失败] 设备预置位查询应答处理: {}", e.getMessage());
                }
                return;
            }
            Element presetListNumElement = rootElement.element("PresetList");
            Element snElement = rootElement.element("SN");
            //该字段可能为通道或则设备的id
            String deviceId = getText(rootElement, "DeviceID");
            String key = DeferredResultHolder.CALLBACK_CMD_PRESETQUERY + deviceId;
            if (snElement == null || presetListNumElement == null) {
                try {
                    responseAck(request, Response.BAD_REQUEST, "xml error");
                } catch (InvalidArgumentException | ParseException | SipException e) {
                    log.error("[命令发送失败] 设备预置位查询应答处理: {}", e.getMessage());
                }
                return;
            }
            int sumNum = Integer.parseInt(presetListNumElement.attributeValue("Num"));
            List<Preset> presetQuerySipReqList = new ArrayList<>();
            if (sumNum > 0) {
                for (Iterator<Element> presetIterator = presetListNumElement.elementIterator(); presetIterator.hasNext(); ) {
                    Element itemListElement = presetIterator.next();
                    Preset presetQuerySipReq = new Preset();
                    for (Iterator<Element> itemListIterator = itemListElement.elementIterator(); itemListIterator.hasNext(); ) {
                        // 遍历item
                        Element itemOne = itemListIterator.next();
                        String name = itemOne.getName();
                        String textTrim = itemOne.getTextTrim();
                        if ("PresetID".equalsIgnoreCase(name)) {
                            presetQuerySipReq.setPresetId(textTrim);
                        } else {
                            presetQuerySipReq.setPresetName(textTrim);
                        }
                    }
                    presetQuerySipReqList.add(presetQuerySipReq);
                }
            }
            RequestMessage requestMessage = new RequestMessage();
            requestMessage.setKey(key);
            requestMessage.setData(presetQuerySipReqList);
            deferredResultHolder.invokeAllResult(requestMessage);
            try {
                responseAck(request, Response.OK);
            } catch (InvalidArgumentException | ParseException | SipException e) {
                log.error("[命令发送失败] 设备预置位查询应答处理: {}", e.getMessage());
            }
        } catch (DocumentException e) {
            log.error("[解析xml]失败: ", e);
        }
    }

    @Override
    public void handForPlatform(RequestEvent evt, Platform parentPlatform, Element rootElement) {

    }

}
