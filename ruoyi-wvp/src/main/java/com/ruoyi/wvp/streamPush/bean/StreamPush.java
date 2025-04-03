package com.ruoyi.wvp.streamPush.bean;

import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.common.enums.ChannelDataType;
import com.ruoyi.wvp.gb28181.bean.CommonGBChannel;
import com.ruoyi.wvp.media.event.media.MediaArrivalEvent;
import com.ruoyi.wvp.utils.DateUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.jetbrains.annotations.NotNull;
import org.springframework.util.ObjectUtils;

/**
 * 推流信息
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class StreamPush extends CommonGBChannel implements Comparable<StreamPush> {
    /**
     * ID
     */
    private Integer id;

    /**
     * 应用名
     */
    private String app;

    /**
     * 流ID
     */
    private String stream;

    /**
     * 使用的流媒体ID
     */
    private String mediaServerId;

    /**
     * 使用的服务ID
     */
    private String serverId;

    /**
     * 推流时间
     */
    private String pushTime;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 是否正在推流
     */
    private boolean pushing;

    /**
     * 拉起离线推流
     */
    private boolean startOfflinePush;

    private String uniqueKey;

    private Integer dataType = ChannelDataType.STREAM_PUSH.value;

    @Override
    public int compareTo(@NotNull StreamPush streamPushItem) {
        return Long.valueOf(DateUtil.yyyy_MM_dd_HH_mm_ssToTimestamp(this.createTime)
                - DateUtil.yyyy_MM_dd_HH_mm_ssToTimestamp(streamPushItem.getCreateTime())).intValue();
    }

    public static StreamPush getInstance(StreamInfo streamInfo) {
        StreamPush streamPush = new StreamPush();
        streamPush.setApp(streamInfo.getApp());
        if (streamInfo.getMediaServer() != null) {
            streamPush.setMediaServerId(streamInfo.getMediaServer().getId());
        }

        streamPush.setStream(streamInfo.getStream());
        streamPush.setCreateTime(DateUtil.getNow());
        streamPush.setServerId(streamInfo.getServerId());
        return streamPush;

    }

    public static StreamPush getInstance(MediaArrivalEvent event, String serverId) {
        StreamPush streamPushItem = new StreamPush();
        streamPushItem.setApp(event.getApp());
        streamPushItem.setMediaServerId(event.getMediaServer().getId());
        streamPushItem.setStream(event.getStream());
        streamPushItem.setCreateTime(DateUtil.getNow());
        streamPushItem.setServerId(serverId);
        return streamPushItem;
    }

    public CommonGBChannel buildCommonGBChannel() {
        if (ObjectUtils.isEmpty(this.getGbDeviceId())) {
            return null;
        }
        if (ObjectUtils.isEmpty(this.getGbName())) {
            this.setGbName(app + "-" + stream);
        }
        this.setDataType(ChannelDataType.STREAM_PUSH.value);
        this.setDataDeviceId(this.getId());
        return this;
    }


}

