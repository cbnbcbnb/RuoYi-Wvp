package com.ruoyi.wvp.gb28181.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.wvp.conf.exception.ControllerException;
import com.ruoyi.wvp.gb28181.bean.Group;
import com.ruoyi.wvp.gb28181.service.IGroupService;
import com.ruoyi.wvp.vmanager.bean.ErrorCode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Tag(name = "分组管理")
@RestController
@RequestMapping("/api/group")
public class GroupController extends BaseController {

    @Autowired
    private IGroupService groupService;

    /**
     * 添加分组
     *
     * @param group
     */
    @ResponseBody
    @PostMapping("/add")
    public AjaxResult add(@RequestBody Group group) {
        groupService.add(group);
        return success();
    }

    /**
     * 查询分组树
     *
     * @param query      要搜索的内容
     * @param parent     所属分组编号
     * @param hasChannel 是否包含通道
     * @return
     */
    @ResponseBody
    @GetMapping("/tree/list")
    public AjaxResult queryForTree(
            @RequestParam(required = false) String query,
            @RequestParam(required = false) Integer parent,
            @RequestParam(required = false) Boolean hasChannel
    ) {
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        return success(groupService.queryForTree(query, parent, hasChannel));
    }

    /**
     * 更新分组
     *
     * @param group
     */
    @ResponseBody
    @PostMapping("/update")
    public AjaxResult update(@RequestBody Group group) {
        groupService.update(group);
        return success();
    }

    /**
     * 删除分组
     *
     * @param id 分组id
     */
    @ResponseBody
    @DeleteMapping("/delete/{id}")
    public AjaxResult delete(@PathVariable Integer id) {
        Assert.notNull(id, "分组id（deviceId）不需要存在");
        boolean result = groupService.delete(id);
        if (!result) {
            throw new ControllerException(ErrorCode.ERROR100.getCode(), "移除失败");
        }
        return success();
    }

    @Operation(summary = "获取所属的行政区划下的行政区划")
    @Parameter(name = "deviceId", description = "当前的行政区划", required = false)
    @ResponseBody
    @GetMapping("/path")
    public List<Group> getPath(String deviceId, String businessGroup) {
        return groupService.getPath(deviceId, businessGroup);
    }

//    @Operation(summary = "根据分组Id查询分组")
//    @Parameter(name = "groupDeviceId", description = "分组节点编号", required = true)
//    @ResponseBody
//    @GetMapping("/one")
//    public Group queryGroupByDeviceId(
//            @RequestParam(required = true) String deviceId
//    ){
//        Assert.hasLength(deviceId, "");
//        return groupService.queryGroupByDeviceId(deviceId);
//    }

//    @Operation(summary = "从通道中同步分组")
//    @ResponseBody
//    @GetMapping("/sync")
//    public void sync(){
//        groupService.syncFromChannel();
//    }
}
