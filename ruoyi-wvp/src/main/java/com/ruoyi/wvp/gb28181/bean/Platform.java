package com.ruoyi.wvp.gb28181.bean;

import lombok.Data;

import java.io.Serializable;

/**
 * 平台信息
 *
 * @author lin
 */
@Data
public class Platform implements Serializable {

    /**
     * 国标-数据库自增ID
     */
    private Integer id;

    /**
     * 是否启用
     */
    private boolean enable;

    /**
     * 名称
     */
    private String name;

    /**
     * SIP服务国标编码
     */
    private String serverGBId;

    /**
     * SIP服务国标域
     */
    private String serverGBDomain;

    /**
     * SIP服务IP
     */
    private String serverIp;

    /**
     * SIP服务端口
     */
    private int serverPort;

    /**
     * 设备国标编号
     */
    private String deviceGBId;

    /**
     * 设备ip
     */
    private String deviceIp;

    /**
     * 设备端口
     */
    private int devicePort;

    /**
     * SIP认证用户名(默认使用设备国标编号)
     */
    private String username;

    /**
     * SIP认证密码
     */
    private String password;

    /**
     * 注册周期 (秒)
     */
    private int expires;

    /**
     * 心跳周期(秒)
     */
    private int keepTimeout;

    /**
     * 传输协议
     */
    private String transport;

    /**
     * 字符集
     */
    private String characterSet;

    /**
     * 允许云台控制
     */
    private boolean ptz;

    /**
     * RTCP流保活
     */
    private boolean rtcp;

    /**
     * 在线状态
     */
    private boolean status;

    /**
     * 通道数量
     */
    private int channelCount;

    /**
     * 已被订阅目录信息
     */
    private boolean catalogSubscribe;

    /**
     * 已被订阅报警信息
     */
    private boolean alarmSubscribe;

    /**
     * 已被订阅移动位置信息
     */
    private boolean mobilePositionSubscribe;

    /**
     * 目录分组-每次向上级发送通道信息时单个包携带的通道数量，取值1,2,4,8
     */
    private int catalogGroup;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 是否作为消息通道
     */
    private boolean asMessageChannel;

    /**
     * 点播回复200OK使用的IP
     */
    private String sendStreamIp;

    /**
     * 是否自动推送通道变化
     */
    private Boolean autoPushChannel;

    /**
     * 目录信息包含平台信息, 0：关闭，1：打开
     */
    private int catalogWithPlatform;

    /**
     * 目录信息包含分组信息, 0：关闭，1：打开
     */
    private int catalogWithGroup;

    /**
     * 目录信息包含行政区划, 0：关闭，1：打开
     */
    private int catalogWithRegion;

    /**
     * 行政区划
     */
    private String civilCode;

    /**
     * 平台厂商
     */
    private String manufacturer;

    /**
     * 平台型号
     */
    private String model;

    /**
     * 平台安装地址
     */
    private String address;

    /**
     * 注册方式（必选）缺省为1；
     * 1-符合IETF RFC 3261标准的认证注册模式；
     * 2-基于口令的双向认证注册模式；
     * 3-基于数字证书的双向认证注册模式(高安全级别要求)；
     * 4-基于数字证书的单向认证注册模式（高安全级别要求）
     */
    private int registerWay = 1;

    /**
     * 保密属性（必选）缺省为0；0-不涉密，1-涉密
     */
    private int secrecy = 0;
}
