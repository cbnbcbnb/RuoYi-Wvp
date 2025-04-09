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
        FetchMainAndSubStreamUris fetchMainAndSubStreamUris = new FetchMainAndSubStreamUris();
        fetchMainAndSubStreamUris.setIp(bo.getIp());
        CountDownLatch latch = new CountDownLatch(3);

        try {
            OnvifManager onvifManager = new OnvifManager();
            onvifManager.setOnvifResponseListener(new OnvifResponseListener() {
                @Override
                public void onResponse(OnvifDevice onvifDevice, OnvifResponse onvifResponse) {
                    System.out.println("onvif-成功--->>>>" + onvifResponse);
                    System.out.println("onvifDevice-成功--->>>>" + onvifDevice);
                }

                @Override
                public void onError(OnvifDevice onvifDevice, int errorCode, String errorDescription) {
                    try {
                        latch.countDown();
                        latch.countDown();
                        latch.countDown();
                        latch.await();
                    } catch (InterruptedException e) {
                        throw new RuntimeException(e);
                    }
                    throw new RuntimeException("onvif操作失败, 错误代码:" + errorCode);
                }
            });

            OnvifDevice onvifDevice = new OnvifDevice(bo.getIp(), bo.getUsername(), bo.getPassword());
            onvifManager.getDeviceInformation(onvifDevice, new OnvifDeviceInformationListener() {
                @Override
                public void onDeviceInformationReceived(OnvifDevice onvifDevice, OnvifDeviceInformation onvifDeviceInformation) {
                    fetchMainAndSubStreamUris.setFirm(onvifDeviceInformation.getManufacturer());
                    fetchMainAndSubStreamUris.setModel(onvifDeviceInformation.getModel());
                    fetchMainAndSubStreamUris.setFirmwareVersion(onvifDeviceInformation.getFirmwareVersion());
                    latch.countDown();
                }
            });
            onvifManager.getMediaProfiles(onvifDevice, new OnvifMediaProfilesListener() {
                @Override
                public void onMediaProfilesReceived(OnvifDevice device, List<OnvifMediaProfile> mediaProfiles) {
                    if(fetchMainAndSubStreamUris.getFirm().equals("HIKVISION")){
                        for (OnvifMediaProfile profile : mediaProfiles) {
                            onvifManager.getMediaStreamURI(device, profile, new OnvifMediaStreamURIListener() {
                                @Override
                                public void onMediaStreamURIReceived(OnvifDevice device, OnvifMediaProfile profile, String mediaUri) {
                                    fetchMainAndSubStreamUris.addStreamUri(profile.getName(), mediaUri);
                                    latch.countDown();
                                }
                            });
                        }
                        try {
                            latch.await();
                        } catch (InterruptedException e) {
                            throw new RuntimeException(e);
                        }
                    }
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
                        onvifManager.getMediaStreamURI(device, mainProfile, new OnvifMediaStreamURIListener() {
                            @Override
                            public void onMediaStreamURIReceived(OnvifDevice device, OnvifMediaProfile profile, String mediaUri) {
                                fetchMainAndSubStreamUris.addStreamUri(profile.getName(), mediaUri);
                                latch.countDown();
                            }
                        });
                    }
                    if (subProfile != null) {
                        onvifManager.getMediaStreamURI(device, subProfile, new OnvifMediaStreamURIListener() {
                            @Override
                            public void onMediaStreamURIReceived(OnvifDevice device, OnvifMediaProfile profile, String mediaUri) {
                                fetchMainAndSubStreamUris.addStreamUri(profile.getName(), mediaUri);
                                latch.countDown();
                            }
                        });
                    }
                }
            });
            latch.await();
        } catch (Exception e) {
            throw new RuntimeException("onvif-报错" + e.getMessage().toString());
        }
        return fetchMainAndSubStreamUris;
    }

}
