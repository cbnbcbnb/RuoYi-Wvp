package com.ruoyi.wvp.media;


import com.ruoyi.wvp.conf.MediaConfig;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.media.event.mediaServer.MediaServerChangeEvent;
import com.ruoyi.wvp.media.service.IMediaServerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 启动是从配置文件加载节点信息，以及发送个节点状态管理去控制节点状态
 */
@Slf4j
@Component
@Order(value=12)
public class MediaServerConfig implements CommandLineRunner {

    @Autowired
    private ApplicationEventPublisher applicationEventPublisher;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private MediaConfig mediaConfig;


    @Override
    public void run(String... strings) throws Exception {
        // 清理所有在线节点的缓存信息
        mediaServerService.clearMediaServerForOnline();
        MediaServer defaultMediaServer = mediaServerService.getDefaultMediaServer();
        MediaServer mediaSerItemInConfig = mediaConfig.getMediaSerItem();
        if (defaultMediaServer != null && mediaSerItemInConfig.getId().equals(defaultMediaServer.getId())) {
            mediaServerService.update(mediaSerItemInConfig);
        }else {
            if (defaultMediaServer != null) {
                mediaServerService.delete(defaultMediaServer);
            }
            MediaServer mediaServerItem = mediaServerService.getOneFromDatabase(mediaSerItemInConfig.getId());
            if (mediaServerItem == null) {
                mediaServerService.add(mediaSerItemInConfig);
            }else {
                mediaServerService.update(mediaSerItemInConfig);
            }
        }
        // 发送媒体节点变化事件
        mediaServerService.syncCatchFromDatabase();
        // 获取所有的zlm， 并开启主动连接
        List<MediaServer> all = mediaServerService.getAllFromDatabase();
        log.info("[媒体节点] 加载节点列表， 共{}个节点", all.size());
        MediaServerChangeEvent event = new MediaServerChangeEvent(this);
        event.setMediaServerItemList(all);
        applicationEventPublisher.publishEvent(event);
    }
}
