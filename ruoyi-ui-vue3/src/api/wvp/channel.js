import request from '@/utils/request'

// 获取通道信息
export function getCommonChannel(id) {
    return request({
        url: `/api/common/channel/one/${id}`,
        method: 'get',
    })
}

// 获取通道信息列表
export function getIndustryCodeList() {
    return request({
        url: `/api/common/channel/industry/list`,
        method: 'get',
    })
}


// 获取通道类型列表
export function getDeviceTypeList() {
    return request({
        url: `/api/common/channel/type/list`,
        method: 'get',
    })
}

// 获取网络标识列表
export function getNetworkIdentificationTypeList() {
    return request({
        url: `/api/common/channel/network/identification/list`,
        method: 'get',
    })
}

// 重置通道
export function resetChannel(id) {
    return request({
        url: `/api/common/channel/reset/${id}`,
        method: 'post',
    })
}

// 修改通道信息
export function updateChannelData(data) {
    return request({
        url: `/api/common/channel/update`,
        method: 'post',
        data: data,
    })
}

// 通知设备上传媒体流
export function sendDevicePush(params) {
    return request({
        url: `/api/play/start/${params.deviceId}/${params.channelId}`,
        method: 'get',
        timeout: 10000 * 6
    })
}

// 新增通道信息
export function addChannelData(data) {
    return request({
        url: `/api/common/channel/add`,
        method: 'post',
        data: data,
    })
}

// 获取通道列表
export function queryListByCivilCode(query) {
    return request({
        url: `/api/common/channel/civilcode/list`,
        method: 'get',
        params: query
    })
}


// 根据ParentId获取通道列表
export function queryListByParentId(query) {
    return request({
        url: `/api/common/channel/parent/list`,
        method: 'get',
        params: query
    })
}

// 添加通道
export function addChannelToRegion(data) {
    return request({
        url: `/api/common/channel/region/add`,
        method: 'post',
        data: data
    })
}

// 删除通道
export function deleteChannelToRegion(data) {
    return request({
        url: `/api/common/channel/region/delete`,
        method: 'post',
        data: data
    })
}

// 删除通道
export function deleteChannelToGroup(data) {
    return request({
        url: `/api/common/channel/group/delete`,
        method: 'post',
        data: data
    })
}

// 添加通道信息
export function addChannelToGroup(data) {
    return request({
        url: `/api/common/channel/group/add`,
        method: 'post',
        data: data
    })
}

