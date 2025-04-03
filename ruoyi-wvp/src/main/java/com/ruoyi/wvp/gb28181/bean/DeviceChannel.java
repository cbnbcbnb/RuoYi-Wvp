package com.ruoyi.wvp.gb28181.bean;

import com.ruoyi.wvp.common.enums.ChannelDataType;
import com.ruoyi.wvp.gb28181.utils.MessageElementForCatalog;
import com.ruoyi.wvp.gb28181.utils.XmlUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.extern.slf4j.Slf4j;
import org.dom4j.Element;
import org.springframework.util.ObjectUtils;

import java.lang.reflect.InvocationTargetException;

/**
 * 通道信息
 */
@Data
@Slf4j
@EqualsAndHashCode(callSuper = true)
public class DeviceChannel extends CommonGBChannel {

    /**
     * 国标-数据库自增ID
     */
    private int id;

    /**
     * 国标-编码
     */
    @MessageElementForCatalog("DeviceID")
    private String deviceId;

    /**
     * 国标-名称
     */
    @MessageElementForCatalog("Name")
    private String name;

    /**
     * 国标-设备厂商
     */
    @MessageElementForCatalog("Manufacturer")
    private String manufacturer;

    /**
     * 国标-设备型号
     */
    @MessageElementForCatalog("Model")
    private String model;

    /**
     * 国标-设备归属
     */
    @MessageElementForCatalog("Owner")
    private String owner;

    /**
     * 国标-行政区域
     */
    @MessageElementForCatalog("CivilCode")
    private String civilCode;

    /**
     * 国标-警区
     */
    @MessageElementForCatalog("Block")
    private String block;

    /**
     * 国标-安装地址
     */
    @MessageElementForCatalog("Address")
    private String address;

    /**
     * 国标-是否有子设备(必选)1有,0没有
     */
    @MessageElementForCatalog("Parental")
    private Integer parental;

    /**
     * 国标-父节点ID
     */
    @MessageElementForCatalog("ParentID")
    private String parentId;

    /**
     * 国标-信令安全模式
     */
    @MessageElementForCatalog("SafetyWay")
    private Integer safetyWay;

    /**
     * 国标-注册方式
     */
    @MessageElementForCatalog("RegisterWay")
    private Integer registerWay;

    /**
     * 国标-证书序列号
     */
    @MessageElementForCatalog("CertNum")
    private String certNum;

    /**
     * 国标-证书有效标识, 缺省为0;证书有效标识:0:无效 1:有效
     */
    @MessageElementForCatalog("Certifiable")
    private Integer certifiable;

    /**
     * 国标-无效原因码(有证书且证书无效的设备必选)
     */
    @MessageElementForCatalog("ErrCode")
    private Integer errCode;

    /**
     * 国标-证书终止有效期(有证书且证书无效的设备必选)
     */
    @MessageElementForCatalog("EndTime")
    private String endTime;

    /**
     * 国标-保密属性(必选)缺省为0;0-不涉密,1-涉密
     */
    @MessageElementForCatalog("Secrecy")
    private Integer secrecy;

    /**
     * 国标-设备/系统IPv4/IPv6地址
     */
    @MessageElementForCatalog("IPAddress")
    private String ipAddress;

    /**
     * 国标-设备/系统端口
     */
    @MessageElementForCatalog("Port")
    private Integer port;

    /**
     * 国标-设备口令
     */
    @MessageElementForCatalog("Password")
    private String password;

    /**
     * 国标-设备状态
     */
    @MessageElementForCatalog("Status")
    private String status;

    /**
     * 国标-经度 WGS-84坐标系
     */
    @MessageElementForCatalog("Longitude")
    private Double longitude;

    /**
     * 国标-纬度 WGS-84坐标系
     */
    @MessageElementForCatalog("Latitude")
    private Double latitude;

    /**
     * 国标-摄像机结构类型,标识摄像机类型: 1-球机; 2-半球; 3-固定枪机; 4-遥控枪机;5-遥控半球;6-多目设备的全景/拼接通道;7-多目设备的分割通道
     */
    @MessageElementForCatalog("Info.PTZType")
    private Integer ptzType;

    /**
     * 国标-摄像机位置类型扩展。1-省际检查站、2-党政机关、3-车站码头、4-中心广场、5-体育场馆、6-商业中心、7-宗教场所、8-校园周边、9-治安复杂区域、10-交通干线
     */
    @MessageElementForCatalog("Info.PositionType")
    private Integer positionType;

    /**
     * 国标-摄像机安装位置室外、室内属性。1-室外、2-室内。
     */
    @MessageElementForCatalog("Info.RoomType")
    private Integer roomType;

    /**
     * 国标-用途属性， 1-治安、2-交通、3-重点。
     */
    @MessageElementForCatalog("Info.UseType")
    private Integer useType;

    /**
     * 国标-摄像机补光属性。1-无补光;2-红外补光;3-白光补光;4-激光补光;9-其他
     */
    @MessageElementForCatalog("Info.SupplyLightType")
    private Integer supplyLightType;

    /**
     * 国标-摄像机监视方位(光轴方向)属性。1-东(西向东)、2-西(东向西)、3-南(北向南)、4-北(南向北)、5-东南(西北到东南)、6-东北(西南到东北)、7-西南(东北到西南)、8-西北(东南到西北)
     */
    @MessageElementForCatalog("Info.DirectionType")
    private Integer directionType;

    /**
     * 国标-摄像机支持的分辨率,可多值
     */
    @MessageElementForCatalog("Info.Resolution")
    private String resolution;

    /**
     * 国标-虚拟组织所属的业务分组ID
     */
    @MessageElementForCatalog({"BusinessGroupID", "Info.BusinessGroupID"})
    private String businessGroupId;

    /**
     * 国标-下载倍速(可选),可多值
     */
    @MessageElementForCatalog("Info.DownloadSpeed")
    private String downloadSpeed;

    /**
     * 国标-空域编码能力,取值0-不支持;1-1级增强(1个增强层);2-2级增强(2个增强层);3-3级增强(3个增强层)
     */
    @MessageElementForCatalog("Info.SVCSpaceSupportMode")
    private Integer svcSpaceSupportMod;

    /**
     * 国标-时域编码能力,取值0-不支持;1-1级增强;2-2级增强;3-3级增强(可选)
     */
    @MessageElementForCatalog("Info.SVCTimeSupportMode")
    private Integer svcTimeSupportMode;

    /**
     * 国标-云台类型描述字符串
     */
    private String ptzTypeText;

    /**
     * 国标-子设备数
     */
    private int subCount;

    /**
     * 国标-流唯一编号，存在表示正在直播
     */
    private String streamId;

    /**
     * 国标-是否含有音频
     */
    private boolean hasAudio;

    /**
     * 国标-GPS的更新时间
     */
    private String gpsTime;

    /**
     * 国标-码流标识，优先级高于设备中码流标识，用于选择码流时组成码流标识。默认为null，不设置。可选值: stream/streamnumber/streamprofile/streamMode
     */
    private String streamIdentification;

    /**
     * 国标-通道类型， 默认0, 0： 普通通道，1 行政区划 2 业务分组/虚拟组织
     */
    private int channelType;

    private Integer dataType = ChannelDataType.GB28181.value;

    public void setPtzType(int ptzType) {
        this.ptzType = ptzType;
        switch (ptzType) {
            case 0:
                this.ptzTypeText = "未知";
                break;
            case 1:
                this.ptzTypeText = "球机";
                break;
            case 2:
                this.ptzTypeText = "半球";
                break;
            case 3:
                this.ptzTypeText = "固定枪机";
                break;
            case 4:
                this.ptzTypeText = "遥控枪机";
                break;
            case 5:
                this.ptzTypeText = "遥控半球";
                break;
            case 6:
                this.ptzTypeText = "多目设备的全景/拼接通道";
                break;
            case 7:
                this.ptzTypeText = "多目设备的分割通道";
                break;
        }
    }

    public static DeviceChannel decode(Element element) throws InvocationTargetException, NoSuchMethodException, InstantiationException, IllegalAccessException {
        DeviceChannel deviceChannel = XmlUtil.elementDecode(element, DeviceChannel.class);
        if (deviceChannel.getCivilCode() != null) {
            if (ObjectUtils.isEmpty(deviceChannel.getCivilCode())
                    || deviceChannel.getCivilCode().length() > 8) {
                deviceChannel.setCivilCode(null);
            }
            // 此处对于不在wvp缓存中的行政区划,默认直接存储.保证即使出现wvp的行政区划缓存过老,也可以通过用户自主创建的方式正常使用系统
        }
        GbCode gbCode = GbCode.decode(deviceChannel.getDeviceId());
        if (gbCode != null && "138".equals(gbCode.getTypeCode())) {
            deviceChannel.setHasAudio(true);
        }
        return deviceChannel;
    }

    public static DeviceChannel decodeWithOnlyDeviceId(Element element) {
        Element deviceElement = element.element("DeviceID");
        DeviceChannel deviceChannel = new DeviceChannel();
        deviceChannel.setDeviceId(deviceElement.getText());
        return deviceChannel;
    }


}
