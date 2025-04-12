package com.ruoyi.wvp.streamProxy.service;

import com.github.pagehelper.PageInfo;
import com.ruoyi.wvp.common.StreamInfo;
import com.ruoyi.wvp.media.bean.MediaServer;
import com.ruoyi.wvp.streamProxy.bean.StreamProxy;
import com.ruoyi.wvp.streamProxy.bean.StreamProxyParam;
import com.ruoyi.wvp.vmanager.bean.ResourceBaseInfo;

import java.util.List;
import java.util.Map;

public interface IStreamProxyService {

    /**
     * 保存视频代理
     * @param param
     */
    StreamInfo save(StreamProxyParam param);

    /**
     * 分页查询
     * @param page
     * @param count
     * @return
     */
    List<StreamProxy> getAll(Integer page, Integer count, String query, Boolean pulling, String mediaServerId);

    /**
     * 删除视频代理
     * @param app
     * @param stream
     */
    void delteByAppAndStream(String app, String stream);

    /**
     * 启用视频代理
     * @param app
     * @param stream
     * @return
     */
    boolean startByAppAndStream(String app, String stream);

    /**
     * 停用用视频代理
     * @param app
     * @param stream
     * @return
     */
    void stopByAppAndStream(String app, String stream);

    /**
     * 获取ffmpeg.cmd模板
     *
     * @return
     */
    Map<String, String> getFFmpegCMDs(MediaServer mediaServerItem);

    /**
     * 根据app与stream获取streamProxy
     * @return
     */
    StreamProxy getStreamProxyByAppAndStream(String app, String streamId);


    /**
     * 新的节点加入
     * @param mediaServer
     * @return
     */
    void zlmServerOnline(MediaServer mediaServer);

    /**
     * 节点离线
     * @param mediaServer
     * @return
     */
    void zlmServerOffline(MediaServer mediaServer);

    /**
     * 更新代理流
     */
    boolean update(StreamProxy streamProxyItem);

    /**
     * 获取统计信息
     * @return
     */
    ResourceBaseInfo getOverview();

    void add(StreamProxy streamProxy);

    StreamProxy getStreamProxy(int id);

    void delete(int id);
}
