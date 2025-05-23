package com.ruoyi.wvp.gb28181.service;


import com.github.pagehelper.PageInfo;
import com.ruoyi.wvp.gb28181.bean.Region;
import com.ruoyi.wvp.gb28181.bean.RegionTree;

import java.util.List;


public interface IRegionService {

    void add(Region region);

    boolean deleteByDeviceId(Integer regionDeviceId);

    /**
     * 查询区划列表
     */
    PageInfo<Region> query(String query, int page, int count);

    /**
     * 更新区域
     */
    void update(Region region);

    List<Region> getAllChild(String parent);

    Region queryRegionByDeviceId(String regionDeviceId);

    List<RegionTree> queryForTree(String query, Integer parent, Boolean hasChannel);

    void syncFromChannel();

    boolean delete(int id);

    boolean batchAdd(List<Region> regionList);

    List<Region> getPath(String deviceId);
}
