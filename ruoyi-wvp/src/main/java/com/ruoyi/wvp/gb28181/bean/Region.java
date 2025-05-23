package com.ruoyi.wvp.gb28181.bean;

import com.ruoyi.wvp.common.CivilCodePo;
import com.ruoyi.wvp.utils.CivilCodeUtil;
import com.ruoyi.wvp.utils.DateUtil;
import lombok.Data;
import org.jetbrains.annotations.NotNull;

/**
 * 区域
 */
@Data
public class Region implements Comparable<Region>{
    /**
     * 数据库自增ID
     */
    private int id;

    /**
     * 区域国标编号
     */
    private String deviceId;

    /**
     * 区域名称
     */
    private String name;

    /**
     * 父区域国标ID
     */
    private Integer parentId;

    /**
     * 父区域国标ID
     */
    private String parentDeviceId;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;

    public static Region getInstance(String commonRegionDeviceId, String commonRegionName, String commonRegionParentId) {
        Region region = new Region();
        region.setDeviceId(commonRegionDeviceId);
        region.setName(commonRegionName);
        region.setParentDeviceId(commonRegionParentId);
        region.setCreateTime(DateUtil.getNow());
        region.setUpdateTime(DateUtil.getNow());
        return region;
    }

    public static Region getInstance(CivilCodePo civilCodePo) {
        Region region = new Region();
        region.setName(civilCodePo.getName());
        region.setDeviceId(civilCodePo.getCode());
        if (civilCodePo.getCode().length() > 2) {
            region.setParentDeviceId(civilCodePo.getParentCode());
        }
        region.setCreateTime(DateUtil.getNow());
        region.setUpdateTime(DateUtil.getNow());
        return region;
    }

    public static Region getInstance(DeviceChannel channel) {
        Region region = new Region();
        region.setName(channel.getName());
        region.setDeviceId(channel.getDeviceId());
        CivilCodePo parentCode = CivilCodeUtil.INSTANCE.getParentCode(channel.getDeviceId());
        if (parentCode != null) {
            region.setParentDeviceId(parentCode.getCode());
        }
        region.setCreateTime(DateUtil.getNow());
        region.setUpdateTime(DateUtil.getNow());
        return region;
    }

    @Override
    public int compareTo(@NotNull Region region) {
        return Integer.compare(Integer.parseInt(this.deviceId), Integer.parseInt(region.getDeviceId()));
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null)
            return false;
        if (this == obj)
            return true;
        if (obj instanceof Region) {
            Region region = (Region) obj;

            // 比较每个属性的值一致时才返回true
            if (region.getId() == this.id) {
                return true;
            }
        }
        return false;
    }

    /**
     * 重写hashcode方法，返回的hashCode一样才再去比较每个属性的值
     */
    @Override
    public int hashCode() {
        return id;
    }
}
