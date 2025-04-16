import request from '@/utils/request'

// 获取上级平台列表
export function listPlatform(query) {
    return request({
        url: `/api/platform/query`,
        method: 'get',
        params: query
    })
}

// 判断上级平台是否存在
export function exitPlatform(serverGBId) {
    return request({
        url: `/api/platform/exit/${serverGBId}`,
        method: 'get',
    })
}

// 获取上级平台信息
export function serverConfig() {
    return request({
        url: `/api/platform/server_config`,
        method: 'get',
    })
}

// 添加上级平台信息
export function addPlatform(data) {
    return request({
        url: `/api/platform/add`,
        method: 'post',
        data: data
    })
}

// 更新上级平台信息
export function updatePlatform(data) {
    return request({
        url: `/api/platform/update`,
        method: 'post',
        data: data
    })
}

// 删除上级平台信息
export function delPlatform(id) {
    return request({
        url: `/api/platform/delete/${id}`,
        method: 'delete',
    })
}

// 上级平台推送通道
export function pushChannel(id) {
    return request({
        url: `/api/platform/channel/push/${id}`,
        method: 'get',
    })
}

// 查询上级平台列表
export function queryChannelList(query) {
    return request({
        url: `/api/platform/channel/list`,
        method: 'get',
        params: query
    })
}

export function addChannel(data) {
    return request({
        url: `/api/platform/channel/add`,
        method: 'post',
        data: data
    })
}

export function delChannelForGB(data) {
    return request({
        url: `/api/platform/channel/remove`,
        method: 'delete',
        data: data
    })
}

export function addChannelByDevice(data) {
    return request({
        url: `/api/platform/channel/device/add`,
        method: 'post',
        data: data
    })
}

export function removeChannelByDevice(data) {
    return request({
        url: `/api/platform/channel/device/remove`,
        method: 'post',
        data: data
    })
}
