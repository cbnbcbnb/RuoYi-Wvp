package com.ruoyi.wvp.media.bean;


import com.ruoyi.wvp.media.zlm.dto.ZLMServerConfig;
import org.springframework.util.ObjectUtils;

/**
 * 流媒体服务信息
 */
public class MediaServer {

    /**
     * ID
     */
    private String id;

    /**
     * IP
     */
    private String ip;

    /**
     * hook使用的IP（zlm访问WVP使用的IP）
     */
    private String hookIp = "127.0.0.1";

    /**
     * SDP IP
     */
    private String sdpIp;

    /**
     * 流IP
     */
    private String streamIp;

    /**
     * HTTP端口
     */
    private int httpPort;

    /**
     * HTTPS端口
     */
    private int httpSSlPort;

    /**
     * RTMP端口
     */
    private int rtmpPort;

    /**
     * flv端口
     */
    private int flvPort;

    /**
     * https-flv端口
     */
    private int flvSSLPort;

    /**
     * ws-flv端口
     */
    private int wsFlvPort;

    /**
     * wss-flv端口
     */
    private int wsFlvSSLPort;

    /**
     * RTMPS端口
     */
    private int rtmpSSlPort;

    /**
     * RTP收流端口（单端口模式有用）
     */
    private int rtpProxyPort;

    /**
     * RTSP端口
     */
    private int rtspPort;

    /**
     * RTSPS端口
     */
    private int rtspSSLPort;

    /**
     * 是否开启自动配置ZLM
     */
    private boolean autoConfig;

    /**
     * ZLM鉴权参数
     */
    private String secret;

    /**
     * keepalive hook触发间隔,单位秒
     */
    private Float hookAliveInterval;

    /**
     * 是否使用多端口模式
     */
    private boolean rtpEnable;

    /**
     * 状态
     */
    private boolean status;

    /**
     * 多端口RTP收流端口范围
     */
    private String rtpPortRange;

    /**
     * RTP发流端口范围
     */
    private String sendRtpPortRange;

    /**
     * assist服务端口
     */
    private int recordAssistPort;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 上次心跳时间
     */
    private String lastKeepaliveTime;

    /**
     * 是否是默认ZLM
     */
    private boolean defaultServer;

    /**
     * 录像存储时长
     */
    private int recordDay;

    /**
     * 录像存储路径
     */
    private String recordPath;

    /**
     * 类型： zlm/abl
     */
    private String type;

    /**
     * 转码的前缀
     */
    private String transcodeSuffix;

    public MediaServer() {
    }

    public MediaServer(ZLMServerConfig zlmServerConfig, String sipIp) {
        id = zlmServerConfig.getGeneralMediaServerId();
        ip = zlmServerConfig.getIp();
        hookIp = ObjectUtils.isEmpty(zlmServerConfig.getHookIp())? sipIp: zlmServerConfig.getHookIp();
        sdpIp = ObjectUtils.isEmpty(zlmServerConfig.getSdpIp())? zlmServerConfig.getIp(): zlmServerConfig.getSdpIp();
        streamIp = ObjectUtils.isEmpty(zlmServerConfig.getStreamIp())? zlmServerConfig.getIp(): zlmServerConfig.getStreamIp();
        httpPort = zlmServerConfig.getHttpPort();
        flvPort = zlmServerConfig.getHttpPort();
        wsFlvPort = zlmServerConfig.getHttpPort();
        httpSSlPort = zlmServerConfig.getHttpSSLport();
        flvSSLPort = zlmServerConfig.getHttpSSLport();
        wsFlvSSLPort = zlmServerConfig.getHttpSSLport();
        rtmpPort = zlmServerConfig.getRtmpPort();
        rtmpSSlPort = zlmServerConfig.getRtmpSslPort();
        rtpProxyPort = zlmServerConfig.getRtpProxyPort();
        rtspPort = zlmServerConfig.getRtspPort();
        rtspSSLPort = zlmServerConfig.getRtspSSlport();
        autoConfig = true; // 默认值true;
        secret = zlmServerConfig.getApiSecret();
        hookAliveInterval = zlmServerConfig.getHookAliveInterval();
        rtpEnable = false; // 默认使用单端口;直到用户自己设置开启多端口
        rtpPortRange = zlmServerConfig.getPortRange().replace("_",","); // 默认使用30000,30500作为级联时发送流的端口号
        recordAssistPort = 0; // 默认关闭
        transcodeSuffix = zlmServerConfig.getTranscodeSuffix();

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getHookIp() {
        return hookIp;
    }

    public void setHookIp(String hookIp) {
        this.hookIp = hookIp;
    }

    public String getSdpIp() {
        return sdpIp;
    }

    public void setSdpIp(String sdpIp) {
        this.sdpIp = sdpIp;
    }

    public String getStreamIp() {
        return streamIp;
    }

    public void setStreamIp(String streamIp) {
        this.streamIp = streamIp;
    }

    public int getHttpPort() {
        return httpPort;
    }

    public void setHttpPort(int httpPort) {
        this.httpPort = httpPort;
    }

    public int getHttpSSlPort() {
        return httpSSlPort;
    }

    public void setHttpSSlPort(int httpSSlPort) {
        this.httpSSlPort = httpSSlPort;
    }

    public int getRtmpPort() {
        return rtmpPort;
    }

    public void setRtmpPort(int rtmpPort) {
        this.rtmpPort = rtmpPort;
    }

    public int getRtmpSSlPort() {
        return rtmpSSlPort;
    }

    public void setRtmpSSlPort(int rtmpSSlPort) {
        this.rtmpSSlPort = rtmpSSlPort;
    }

    public int getRtpProxyPort() {
        return rtpProxyPort;
    }

    public void setRtpProxyPort(int rtpProxyPort) {
        this.rtpProxyPort = rtpProxyPort;
    }

    public int getRtspPort() {
        return rtspPort;
    }

    public void setRtspPort(int rtspPort) {
        this.rtspPort = rtspPort;
    }

    public int getRtspSSLPort() {
        return rtspSSLPort;
    }

    public void setRtspSSLPort(int rtspSSLPort) {
        this.rtspSSLPort = rtspSSLPort;
    }

    public boolean isAutoConfig() {
        return autoConfig;
    }

    public void setAutoConfig(boolean autoConfig) {
        this.autoConfig = autoConfig;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }

    public boolean isRtpEnable() {
        return rtpEnable;
    }

    public void setRtpEnable(boolean rtpEnable) {
        this.rtpEnable = rtpEnable;
    }

    public String getRtpPortRange() {
        return rtpPortRange;
    }

    public void setRtpPortRange(String rtpPortRange) {
        this.rtpPortRange = rtpPortRange;
    }

    public int getRecordAssistPort() {
        return recordAssistPort;
    }

    public void setRecordAssistPort(int recordAssistPort) {
        this.recordAssistPort = recordAssistPort;
    }

    public boolean isDefaultServer() {
        return defaultServer;
    }

    public void setDefaultServer(boolean defaultServer) {
        this.defaultServer = defaultServer;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getLastKeepaliveTime() {
        return lastKeepaliveTime;
    }

    public void setLastKeepaliveTime(String lastKeepaliveTime) {
        this.lastKeepaliveTime = lastKeepaliveTime;
    }

    public Float getHookAliveInterval() {
        return hookAliveInterval;
    }

    public void setHookAliveInterval(Float hookAliveInterval) {
        this.hookAliveInterval = hookAliveInterval;
    }

    public String getSendRtpPortRange() {
        return sendRtpPortRange;
    }

    public void setSendRtpPortRange(String sendRtpPortRange) {
        this.sendRtpPortRange = sendRtpPortRange;
    }

    public int getRecordDay() {
        return recordDay;
    }

    public void setRecordDay(int recordDay) {
        this.recordDay = recordDay;
    }

    public String getRecordPath() {
        return recordPath;
    }

    public void setRecordPath(String recordPath) {
        this.recordPath = recordPath;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getFlvPort() {
        return flvPort;
    }

    public void setFlvPort(int flvPort) {
        this.flvPort = flvPort;
    }

    public int getFlvSSLPort() {
        return flvSSLPort;
    }

    public void setFlvSSLPort(int flvSSLPort) {
        this.flvSSLPort = flvSSLPort;
    }

    public int getWsFlvPort() {
        return wsFlvPort;
    }

    public void setWsFlvPort(int wsFlvPort) {
        this.wsFlvPort = wsFlvPort;
    }

    public int getWsFlvSSLPort() {
        return wsFlvSSLPort;
    }

    public void setWsFlvSSLPort(int wsFlvSSLPort) {
        this.wsFlvSSLPort = wsFlvSSLPort;
    }

    public String getTranscodeSuffix() {
        return transcodeSuffix;
    }

    public void setTranscodeSuffix(String transcodeSuffix) {
        this.transcodeSuffix = transcodeSuffix;
    }
}
