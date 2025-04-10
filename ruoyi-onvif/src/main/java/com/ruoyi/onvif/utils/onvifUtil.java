package com.ruoyi.onvif.utils;

import be.teletask.onvif.OnvifManager;
import be.teletask.onvif.listeners.OnvifDeviceInformationListener;
import be.teletask.onvif.listeners.OnvifMediaProfilesListener;
import be.teletask.onvif.listeners.OnvifMediaStreamURIListener;
import be.teletask.onvif.listeners.OnvifResponseListener;
import be.teletask.onvif.models.OnvifDevice;
import be.teletask.onvif.models.OnvifDeviceInformation;
import be.teletask.onvif.models.OnvifMediaProfile;
import be.teletask.onvif.responses.OnvifResponse;
import com.ruoyi.onvif.domain.FetchMainAndSubStreamUris;
import com.ruoyi.onvif.domain.bo.FetchMainAndSubStreamUrisBo;

import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

/**
 * onvif工具类
 * @Author: 陈江灿
 * @CreateTime: 2025-04-09
 */
public class onvifUtil {

    /**
     * 获取onvif设备信息
     */
    public static FetchMainAndSubStreamUris fetchMainAndSubStreamUris(FetchMainAndSubStreamUrisBo bo) {
        final FetchMainAndSubStreamUris result = new FetchMainAndSubStreamUris();
        result.setIp(bo.getIp());

        // 使用AtomicReference包装CountDownLatch
        final AtomicReference<CountDownLatch> latchRef = new AtomicReference<>(new CountDownLatch(1));
        final AtomicInteger pendingUriRequests = new AtomicInteger(0);

        try {
            OnvifManager onvifManager = new OnvifManager();
            onvifManager.setOnvifResponseListener(new OnvifResponseListener() {
                @Override
                public void onResponse(OnvifDevice onvifDevice, OnvifResponse onvifResponse) {}

                @Override
                public void onError(OnvifDevice onvifDevice, int errorCode, String errorDescription) {
                    CountDownLatch currentLatch = latchRef.get();
                    while (currentLatch.getCount() > 0) {
                        currentLatch.countDown();
                    }
                    throw new RuntimeException("onvif操作失败, 错误代码:" + errorCode);
                }
            });

            OnvifDevice onvifDevice = new OnvifDevice(bo.getIp(), bo.getUsername(), bo.getPassword());

            // 第一阶段：获取设备信息
            onvifManager.getDeviceInformation(onvifDevice, new OnvifDeviceInformationListener() {
                @Override
                public void onDeviceInformationReceived(OnvifDevice onvifDevice, OnvifDeviceInformation onvifDeviceInformation) {
                    result.setFirm(onvifDeviceInformation.getManufacturer());
                    result.setModel(onvifDeviceInformation.getModel());
                    result.setFirmwareVersion(onvifDeviceInformation.getFirmwareVersion());
                    latchRef.get().countDown();
                }
            });

            // 等待设备信息完成
            if (!latchRef.get().await(10, TimeUnit.SECONDS)) {
                throw new RuntimeException("获取设备信息超时");
            }

            // 重置latch用于URI请求
            latchRef.set(new CountDownLatch(1));

            // 第二阶段：获取媒体配置
            onvifManager.getMediaProfiles(onvifDevice, new OnvifMediaProfilesListener() {
                @Override
                public void onMediaProfilesReceived(OnvifDevice device, List<OnvifMediaProfile> mediaProfiles) {
                    int uriCount = result.getFirm().equals("HIKVISION")
                            ? mediaProfiles.size()
                            : (int) mediaProfiles.stream()
                            .filter(p -> p.getName().contains("Main") || p.getName().contains("High") ||
                                    p.getName().contains("Sub") || p.getName().contains("Low"))
                            .count();

                    if (uriCount == 0) {
                        latchRef.get().countDown();
                        return;
                    }

                    pendingUriRequests.set(uriCount);

                    // 创建URI监听器
                    OnvifMediaStreamURIListener uriListener = new OnvifMediaStreamURIListener() {
                        @Override
                        public void onMediaStreamURIReceived(OnvifDevice device, OnvifMediaProfile profile, String mediaUri) {
                            result.addStreamUri(profile.getName(), mediaUri);
                            if (pendingUriRequests.decrementAndGet() == 0) {
                                latchRef.get().countDown();
                            }
                        }
                    };

                    if (result.getFirm().equals("HIKVISION")) {
                        for (OnvifMediaProfile profile : mediaProfiles) {
                            onvifManager.getMediaStreamURI(device, profile, uriListener);
                        }
                    } else {
                        OnvifMediaProfile mainProfile = null;
                        OnvifMediaProfile subProfile = null;
                        for (OnvifMediaProfile profile : mediaProfiles) {
                            if (profile.getName().contains("Main") || profile.getName().contains("High")) {
                                mainProfile = profile;
                            } else if (profile.getName().contains("Sub") || profile.getName().contains("Low")) {
                                subProfile = profile;
                            }
                        }
                        if (mainProfile != null) {
                            onvifManager.getMediaStreamURI(device, mainProfile, uriListener);
                        }
                        if (subProfile != null) {
                            onvifManager.getMediaStreamURI(device, subProfile, uriListener);
                        }
                    }
                }
            });

            // 等待URI获取完成
            if (!latchRef.get().await(20, TimeUnit.SECONDS)) {
                throw new RuntimeException("获取媒体URI超时，已完成：" +
                        (pendingUriRequests.get() - latchRef.get().getCount()) + "/" + pendingUriRequests.get());
            }
        } catch (Exception e) {
            throw new RuntimeException("onvif操作失败: " + e.getMessage(), e);
        }
        return result;
    }


}
