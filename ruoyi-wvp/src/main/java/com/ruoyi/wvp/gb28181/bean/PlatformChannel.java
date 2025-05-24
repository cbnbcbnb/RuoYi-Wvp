package com.ruoyi.wvp.gb28181.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 平台通道
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class PlatformChannel extends CommonGBChannel {

    /**
     * ID
     */
    private int id;

    /**
     * 平台ID
     */
    private int platformId;

    /**
     * 国标-编码
     */
    private String customDeviceId;

    /**
     * 国标-名称
     */
    private String customName;

    /**
     * 国标-设备厂商
     */
    private String customManufacturer;

    /**
     * 国标-设备型号
     */
    private String customModel;

    /**
     * 国标-设备归属
     */
    private String customOwner;

    /**
     * 国标-行政区域
     */
    private String customCivilCode;

    /**
     * 国标-警区
     */
    private String customBlock;

    /**
     * 国标-安装地址
     */
    private String customAddress;

    /**
     * 国标-是否有子设备
     */
    private Integer customParental;

    /**
     * 国标-父节点ID
     */
    private String customParentId;

    /**
     * 国标-信令安全模式
     */
    private Integer customSafetyWay;

    /**
     * 国标-注册方式
     */
    private Integer customRegisterWay;

    /**
     * 国标-证书序列号
     */
    private Integer customCertNum;

    /**
     * 国标-证书有效标识
     */
    private Integer customCertifiable;

    /**
     * 国标-无效原因码(有证书且证书无效的设备必选)
     */
    private Integer customErrCode;

    /**
     * 国标-证书终止有效期(有证书且证书无效的设备必选)
     */
    private Integer customEndTime;

    /**
     * 国标-摄像机安全能力等级代码
     */
    private String customSecurityLevelCode;

    /**
     * 国标-保密属性(必选)缺省为0;0-不涉密,1-涉密
     */
    private Integer customSecrecy;

    /**
     * 国标-设备/系统IPv4/IPv6地址
     */
    private String customIpAddress;

    /**
     * 国标-设备/系统端口
     */
    private Integer customPort;

    /**
     * 国标-设备口令
     */
    private String customPassword;

    /**
     * 国标-设备状态
     */
    private String customStatus;

    /**
     * 国标-经度 WGS-84坐标系
     */
    private Double customLongitude;

    /**
     * 国标-纬度 WGS-84坐标系
     */
    private Double customLatitude;

    /**
     * 国标-虚拟组织所属的业务分组ID
     */
    private String customBusinessGroupId;

    /**
     * 国标-摄像机结构类型,标识摄像机类型: 1-球机; 2-半球; 3-固定枪机; 4-遥控枪机;5-遥控半球;6-多目设备的全景/拼接通道;7-多目设备的分割通道
     */
    private Integer customPtzType;

    /**
     * 摄像机位置类型扩展。1-省际检查站、2-党政机关、3-车站码头、4-中心广场、5-体育场馆、6-商业中心、7-宗教场所、
     * 8-校园周边、9-治安复杂区域、10-交通干线。当目录项为摄像机时可选。
     */
    private Integer customPositionType;

    /**
     * 国标-摄像机光电成像类型。1-可见光成像;2-热成像;3-雷达成像;4-X光成像;5-深度光场成像;9-其他。可多值,
     */
    private String customPhotoelectricImagingTyp;

    /**
     * 国标-摄像机采集部位类型
     */
    private String customCapturePositionType;

    /**
     * 国标-摄像机安装位置室外、室内属性。1-室外、2-室内。
     */
    private Integer customRoomType;

    /**
     * 国标-用途属性
     */
    private Integer customUseType;

    /**
     * 国标-摄像机补光属性。1-无补光;2-红外补光;3-白光补光;4-激光补光;9-其他
     */
    private Integer customSupplyLightType;

    /**
     * 国标-摄像机监视方位(光轴方向)属性。1-东(西向东)、2-西(东向西)、3-南(北向南)、4-北(南向北)、
     * 5-东南(西北到东南)、6-东北(西南到东北)、7-西南(东北到西南)、8-西北(东南到西北)
     */
    private Integer customDirectionType;

    /**
     * 国标-摄像机支持的分辨率,可多值
     */
    private String customResolution;

    /**
     * 国标-摄像机支持的码流编号列表,用于实时点播时指定码流编号(可选)
     */
    private String customStreamNumberList;

    /**
     * 国标-下载倍速(可选),可多值
     */
    private String customDownloadSpeed;

    /**
     * 国标-空域编码能力,取值0-不支持;1-1级增强(1个增强层);2-2级增强(2个增强层);3-3级增强(3个增强层)
     */
    private Integer customSvcSpaceSupportMod;

    /**
     * 国标-时域编码能力,取值0-不支持;1-1级增强;2-2级增强;3-3级增强(可选)
     */
    private Integer customSvcTimeSupportMode;

    /**
     * 国标- SSVC增强层与基本层比例能力
     */
    private String customSsvcRatioSupportList;

    /**
     * 国标-移动采集设备类型(仅移动采集设备适用,必选);1-移动机器人载摄像机;2-执法记录仪;3-移动单兵设备;
     * 4-车载视频记录设备;5-无人机载摄像机;9-其他
     */
    private Integer customMobileDeviceType;

    /**
     * 国标-摄像机水平视场角(可选),取值范围大于0度小于等于360度
     */
    private Double customHorizontalFieldAngle;

    /**
     * 国标-摄像机竖直视场角(可选),取值范围大于0度小于等于360度
     */
    private Double customVerticalFieldAngle;

    /**
     * 国标-摄像机可视距离(可选),单位:米
     */
    private Double customMaxViewDistance;

    /**
     * 国标-基层组织编码(必选,非基层建设时为“000000”)
     */
    private String customGrassrootsCode;

    /**
     * 国标-监控点位类型(当为摄像机时必选),1-一类视频监控点;2-二类视频监控点;3-三类视频监控点;9-其他点位。
     */
    private Integer customPoType;

    /**
     * 国标-点位俗称
     */
    private String customPoCommonName;

    /**
     * 国标-设备MAC地址(可选),用“XX-XX-XX-XX-XX-XX”格式表达
     */
    private String customMac;

    /**
     * 国标-摄像机卡口功能类型,01-人脸卡口;02-人员卡口;03-机动车卡口;04-非机动车卡口;05-物品卡口;99-其他
     */
    private String customFunctionType;

    /**
     * 国标-摄像机视频编码格式
     */
    private String customEncodeType;

    /**
     * 国标-摄像机安装使用时间
     */
    private String customInstallTime;

    /**
     * 国标-摄像机所属管理单位名称
     */
    private String customManagementUnit;

    /**
     * 国标-摄像机所属管理单位联系人的联系方式(电话号码,可多值,用英文半角“/”分割)
     */
    private String customContactInfo;

    /**
     * 国标-录像保存天数(可选)
     */
    private Integer customRecordSaveDays;

    /**
     * 国标-国民经济行业分类代码(可选)
     */
    private String customIndustrialClassification;

}
