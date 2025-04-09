package com.ruoyi.onvif.test;

import be.teletask.onvif.OnvifManager;
import be.teletask.onvif.listeners.OnvifMediaProfilesListener;
import be.teletask.onvif.listeners.OnvifMediaStreamURIListener;
import be.teletask.onvif.listeners.OnvifResponseListener;
import be.teletask.onvif.models.OnvifDevice;
import be.teletask.onvif.models.OnvifMediaProfile;
import be.teletask.onvif.responses.OnvifResponse;

import java.util.List;

/**
 * onvif 测试类
 *
 * @Author: 陈江灿
 * @CreateTime: 2025-04-09
 */
public class Test {

    // 主方法测试
    public static void main(String[] args) {
        String camera = "http://192.168.158.63/onvif/device_service";
        String ip = "192.168.158.63";
        String username = "admin";
        String password = "admin123";

        try {
            OnvifManager onvifManager = new OnvifManager();
            onvifManager.setOnvifResponseListener(new OnvifResponseListener() {
                @Override
                public void onResponse(OnvifDevice onvifDevice, OnvifResponse onvifResponse) {
                    System.out.println("onvif-成功--->>>>" + onvifResponse);
                    System.out.println("onvifDevice-成功--->>>>" + onvifDevice);
                }

                @Override
                public void onError(OnvifDevice onvifDevice, int i, String s) {
                    System.out.println("onvif-失败--->>>>" + onvifDevice);
                }
            });

            OnvifDevice onvifDevice = new OnvifDevice(ip, username, password);
            onvifManager.getMediaProfiles(onvifDevice, new OnvifMediaProfilesListener() {
                @Override
                public void onMediaProfilesReceived(OnvifDevice device, List<OnvifMediaProfile> mediaProfiles) {
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
                                System.out.println("主码流 RTSP 地址: " + mediaUri);
                            }
                        });
                    }

                    if (subProfile != null) {
                        onvifManager.getMediaStreamURI(device, subProfile, new OnvifMediaStreamURIListener() {
                            @Override
                            public void onMediaStreamURIReceived(OnvifDevice device, OnvifMediaProfile profile, String mediaUri) {
                                System.out.println("子码流 RTSP 地址: " + mediaUri);
                            }
                        });
                    }
                }
            });
        } catch (Exception e) {
            System.out.println("onvif-报错--->>>>" + e.getMessage());
        }
    }
}
