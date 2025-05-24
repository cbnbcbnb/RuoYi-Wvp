package com.ruoyi.wvp.gb28181.bean;


import com.ruoyi.common.core.domain.WvpBaseEntity;
import lombok.Data;

/**
 * 国标设备/平台
 *
 * @author lin
 */
@Data
public class Device extends WvpBaseEntity {

    /**
     * 当前页码
     */
    private int pageNum;

    /**
     * 每页大小
     */
    private int pageSize;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 部门名称
     */
    private String deptName;

    /**
     * 国标-数据库自增ID
     */
    private int id;

    /**
     * 设备国标编号
     */
    private String deviceId;

    /**
     * 设备名
     */
    private String name;

    /**
     * 生产厂商
     */
    private String manufacturer;

    /**
     * 型号
     */
    private String model;

    /**
     * 固件版本
     */
    private String firmware;

    /**
     * 在线状态
     */
    private String status;

    /**
     * 传输协议
     * UDP/TCP
     */
    private String transport;

    /**
     * 数据流传输模式
     * UDP:udp传输
     * TCP-ACTIVE：tcp主动模式
     * TCP-PASSIVE：tcp被动模式
     */
    private String streamMode;

    /**
     * wan地址_ip
     */
    private String ip;

    /**
     * wan地址_port
     */
    private int port;

    /**
     * wan地址
     */
    private String hostAddress;

    /**
     * 在线
     * 是否在线，true为在线，false为离线
     */
    private boolean onLine;

    /**
     * 注册时间
     */
    private String registerTime;

    /**
     * 心跳时间
     */
    private String keepaliveTime;

    /**
     * 心跳间隔
     */
    private Integer heartBeatInterval;

    /**
     * 心跳超时次数
     */
    private Integer heartBeatCount;

    /**
     * 定位功能支持情况
     * 取值:0-不支持;1-支持 GPS定位;2-支持北斗定位(可选,默认取值为0)
     */
    private Integer positionCapability;

    /**
     * 通道个数
     */
    private int channelCount;

    /**
     * 注册有效期
     */
    private int expires;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 设备使用的媒体id, 默认为null
     */
    private String mediaServerId;

    /**
     * 字符集, 支持 UTF-8 与 GB2312
     */
    private String charset;

    /**
     * 目录订阅周期，0为不订阅
     */
    private int subscribeCycleForCatalog;

    /**
     * 移动设备位置订阅周期，0为不订阅
     */
    private int subscribeCycleForMobilePosition;

    /**
     * 移动设备位置信息上报时间间隔,单位:秒,默认值5
     */
    private int mobilePositionSubmissionInterval = 5;

    /**
     * 报警订阅周期，0为不订阅
     */
    private int subscribeCycleForAlarm;

    /**
     * 是否开启ssrc校验，默认关闭，开启可以防止串流
     */
    private boolean ssrcCheck = false;

    /**
     * 地理坐标系， 目前支持 WGS84,GCJ02, 此字段保留，暂无用
     */
    private String geoCoordSys;

    /**
     * 密码
     */
    private String password;

    /**
     * 收流IP
     */
    private String sdpIp;

    /**
     * SIP交互IP（设备访问平台的IP）
     */
    private String localIp;

    /**
     * 是否作为消息通道
     */
    private boolean asMessageChannel;

    /**
     * 设备注册的事务信息
     */
    private SipTransactionInfo sipTransactionInfo;

    /**
     * 控制语音对讲流程，释放收到ACK后发流
     */
    private boolean broadcastPushAfterAck;
}
