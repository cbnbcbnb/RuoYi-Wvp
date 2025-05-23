package com.ruoyi.wvp.vmanager.bean;


import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.media.bean.MediaInfo;
import com.ruoyi.wvp.service.bean.DownloadFileInfo;

/**
 * 流信息
 */
public class StreamContent {

    /**
     * 应用名
     */
    private String app;

    /**
     * 流ID
     */
    private String stream;

    /**
     * IP
     */
    private String ip;

    /**
     * HTTP-FLV流地址
     */
    private String flv;

    /**
     * HTTPS-FLV流地址
     */
    private String https_flv;

    /**
     * Websocket-FLV流地址
     */
    private String ws_flv;

    /**
     * Websockets-FLV流地址
     */
    private String wss_flv;

    /**
     * HTTP-FMP4流地址
     */
    private String fmp4;

    /**
     * HTTPS-FMP4流地址
     */
    private String https_fmp4;

    /**
     * Websocket-FMP4流地址
     */
    private String ws_fmp4;

    /**
     * Websockets-FMP4流地址
     */
    private String wss_fmp4;

    /**
     * HLS流地址
     */
    private String hls;

    /**
     * HTTPS-HLS流地址
     */
    private String https_hls;

    /**
     * Websocket-HLS流地址
     */
    private String ws_hls;

    /**
     * Websockets-HLS流地址
     */
    private String wss_hls;

    /**
     * HTTP-TS流地址
     */
    private String ts;

    /**
     * HTTPS-TS流地址
     */
    private String https_ts;

    /**
     * Websocket-TS流地址
     */
    private String ws_ts;

    /**
     * Websockets-TS流地址
     */
    private String wss_ts;

    /**
     * RTMP流地址
     */
    private String rtmp;

    /**
     * RTMPS流地址
     */
    private String rtmps;

    /**
     * RTSP流地址
     */
    private String rtsp;

    /**
     * RTSPS流地址
     */
    private String rtsps;

    /**
     * RTC流地址
     */
    private String rtc;

    /**
     * RTCS流地址
     */
    private String rtcs;

    /**
     * 流媒体ID
     */
    private String mediaServerId;

    /**
     * 流编码信息
     */
    private MediaInfo mediaInfo;

    /**
     * 开始时间
     */
    private String startTime;

    /**
     * 结束时间
     */
    private String endTime;

    /**
     * 文件下载地址（录像下载使用）
     */
    private DownloadFileInfo downLoadFilePath;

    /**
     * 转码后的视频流
     */
    private StreamContent transcodeStream;

    private double progress;

    public StreamContent(StreamInfo streamInfo) {
        if (streamInfo == null) {
            return;
        }
        this.app = streamInfo.getApp();
        this.stream = streamInfo.getStream();
        if (streamInfo.getFlv() != null) {
            this.flv = streamInfo.getFlv().getUrl();
        }
        if (streamInfo.getHttps_flv() != null) {
            this.https_flv = streamInfo.getHttps_flv().getUrl();
        }
        if (streamInfo.getWs_flv() != null) {
            this.ws_flv = streamInfo.getWs_flv().getUrl();
        }
        if (streamInfo.getWss_flv() != null) {
            this.wss_flv = streamInfo.getWss_flv().getUrl();
        }
        if (streamInfo.getFmp4() != null) {
            this.fmp4 = streamInfo.getFmp4().getUrl();
        }
        if (streamInfo.getHttps_fmp4() != null) {
            this.https_fmp4 = streamInfo.getHttps_fmp4().getUrl();
        }
        if (streamInfo.getWs_fmp4() != null) {
            this.ws_fmp4 = streamInfo.getWs_fmp4().getUrl();
        }
        if (streamInfo.getWss_fmp4() != null) {
            this.wss_fmp4 = streamInfo.getWss_fmp4().getUrl();
        }
        if (streamInfo.getHls() != null) {
            this.hls = streamInfo.getHls().getUrl();
        }
        if (streamInfo.getHttps_hls() != null) {
            this.https_hls = streamInfo.getHttps_hls().getUrl();
        }
        if (streamInfo.getWs_hls() != null) {
            this.ws_hls = streamInfo.getWs_hls().getUrl();
        }
        if (streamInfo.getWss_hls() != null) {
            this.wss_hls = streamInfo.getWss_hls().getUrl();
        }
        if (streamInfo.getTs() != null) {
            this.ts = streamInfo.getTs().getUrl();
        }
        if (streamInfo.getHttps_ts() != null) {
            this.https_ts = streamInfo.getHttps_ts().getUrl();
        }
        if (streamInfo.getWs_ts() != null) {
            this.ws_ts = streamInfo.getWs_ts().getUrl();
        }
        if (streamInfo.getRtmp() != null) {
            this.rtmp = streamInfo.getRtmp().getUrl();
        }
        if (streamInfo.getRtmps() != null) {
            this.rtmps = streamInfo.getRtmps().getUrl();
        }
        if (streamInfo.getRtsp() != null) {
            this.rtsp = streamInfo.getRtsp().getUrl();
        }
        if (streamInfo.getRtsps() != null) {
            this.rtsps = streamInfo.getRtsps().getUrl();
        }
        if (streamInfo.getRtc() != null) {
            this.rtc = streamInfo.getRtc().getUrl();
        }
        if (streamInfo.getRtcs() != null) {
            this.rtcs = streamInfo.getRtcs().getUrl();
        }
        if (streamInfo.getMediaServer() != null) {
            this.mediaServerId = streamInfo.getMediaServer().getId();
        }

        this.mediaInfo = streamInfo.getMediaInfo();
        this.startTime = streamInfo.getStartTime();
        this.endTime = streamInfo.getEndTime();
        this.progress = streamInfo.getProgress();

        if (streamInfo.getDownLoadFilePath() != null) {
            this.downLoadFilePath = streamInfo.getDownLoadFilePath();
        }
        if (streamInfo.getTranscodeStream() != null) {
            this.transcodeStream = new StreamContent(streamInfo.getTranscodeStream());
        }
    }

    public StreamContent getTranscodeStream() {
        return transcodeStream;
    }

    public void setTranscodeStream(StreamContent transcodeStream) {
        this.transcodeStream = transcodeStream;
    }

    public String getApp() {
        return app;
    }

    public void setApp(String app) {
        this.app = app;
    }

    public String getStream() {
        return stream;
    }

    public void setStream(String stream) {
        this.stream = stream;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getFlv() {
        return flv;
    }

    public void setFlv(String flv) {
        this.flv = flv;
    }

    public String getHttps_flv() {
        return https_flv;
    }

    public void setHttps_flv(String https_flv) {
        this.https_flv = https_flv;
    }

    public String getWs_flv() {
        return ws_flv;
    }

    public void setWs_flv(String ws_flv) {
        this.ws_flv = ws_flv;
    }

    public String getWss_flv() {
        return wss_flv;
    }

    public void setWss_flv(String wss_flv) {
        this.wss_flv = wss_flv;
    }

    public String getFmp4() {
        return fmp4;
    }

    public void setFmp4(String fmp4) {
        this.fmp4 = fmp4;
    }

    public String getHttps_fmp4() {
        return https_fmp4;
    }

    public void setHttps_fmp4(String https_fmp4) {
        this.https_fmp4 = https_fmp4;
    }

    public String getWs_fmp4() {
        return ws_fmp4;
    }

    public void setWs_fmp4(String ws_fmp4) {
        this.ws_fmp4 = ws_fmp4;
    }

    public String getWss_fmp4() {
        return wss_fmp4;
    }

    public void setWss_fmp4(String wss_fmp4) {
        this.wss_fmp4 = wss_fmp4;
    }

    public String getHls() {
        return hls;
    }

    public void setHls(String hls) {
        this.hls = hls;
    }

    public String getHttps_hls() {
        return https_hls;
    }

    public void setHttps_hls(String https_hls) {
        this.https_hls = https_hls;
    }

    public String getWs_hls() {
        return ws_hls;
    }

    public void setWs_hls(String ws_hls) {
        this.ws_hls = ws_hls;
    }

    public String getWss_hls() {
        return wss_hls;
    }

    public void setWss_hls(String wss_hls) {
        this.wss_hls = wss_hls;
    }

    public String getTs() {
        return ts;
    }

    public void setTs(String ts) {
        this.ts = ts;
    }

    public String getHttps_ts() {
        return https_ts;
    }

    public void setHttps_ts(String https_ts) {
        this.https_ts = https_ts;
    }

    public String getWs_ts() {
        return ws_ts;
    }

    public void setWs_ts(String ws_ts) {
        this.ws_ts = ws_ts;
    }

    public String getWss_ts() {
        return wss_ts;
    }

    public void setWss_ts(String wss_ts) {
        this.wss_ts = wss_ts;
    }

    public String getRtmp() {
        return rtmp;
    }

    public void setRtmp(String rtmp) {
        this.rtmp = rtmp;
    }

    public String getRtmps() {
        return rtmps;
    }

    public void setRtmps(String rtmps) {
        this.rtmps = rtmps;
    }

    public String getRtsp() {
        return rtsp;
    }

    public void setRtsp(String rtsp) {
        this.rtsp = rtsp;
    }

    public String getRtsps() {
        return rtsps;
    }

    public void setRtsps(String rtsps) {
        this.rtsps = rtsps;
    }

    public String getRtc() {
        return rtc;
    }

    public void setRtc(String rtc) {
        this.rtc = rtc;
    }

    public String getRtcs() {
        return rtcs;
    }

    public void setRtcs(String rtcs) {
        this.rtcs = rtcs;
    }

    public String getMediaServerId() {
        return mediaServerId;
    }

    public void setMediaServerId(String mediaServerId) {
        this.mediaServerId = mediaServerId;
    }

    public MediaInfo getMediaInfo() {
        return mediaInfo;
    }

    public void setMediaInfo(MediaInfo mediaInfo) {
        this.mediaInfo = mediaInfo;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public double getProgress() {
        return progress;
    }

    public void setProgress(double progress) {
        this.progress = progress;
    }

    public DownloadFileInfo getDownLoadFilePath() {
        return downLoadFilePath;
    }

    public void setDownLoadFilePath(DownloadFileInfo downLoadFilePath) {
        this.downLoadFilePath = downLoadFilePath;
    }
}
