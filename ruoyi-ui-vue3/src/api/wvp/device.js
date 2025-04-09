import request from '@/utils/request'

// 分页查询国标设备
export function listDevice(query) {
    return request({
        url: '/api/device/query/devices',
        method: 'get',
        params: query
    })
}

// 修改数据流传输模式
export function updateTransport(data) {
    return request({
        url: `/api/device/query/transport/${data.deviceId}/${data.streamMode}`,
        method: 'post',
    })
}

// 开启/关闭目录订阅
export function subscribeCatalog(data) {
    return request({
        url: `/api/device/query/subscribe/catalog/${data.id}/${data.cycle}`,
        method: 'post',
    })
}

// 开启/关闭移动位置订阅
export function subscribeMobilePosition(data) {
    return request({
        url: `/api/device/query/subscribe/mobile-position/${data.id}/${data.cycle}/${data.interval}`,
        method: 'post',
    })
}

// 使用ID查询国标设备
export function getDeviceById(deviceId) {
    return request({
        url: `/api/device/query/devices/${deviceId}`,
        method: 'get',
    })
}

// 更新设备信息
export function updateDevice(data) {
    return request({
        url: `/api/device/query/device/update/`,
        method: 'post',
        data: data
    })
}

// 刷新对应设备
export function deleteDevice(deviceId) {
    return request({
        url: `/api/device/query/devices/${deviceId}/delete`,
        method: 'delete',
    })
}

// 移除设备
export function syncStatus(deviceId) {
    return request({
        url: `/api/device/query/${deviceId}/sync_status`,
        method: 'post',
    })
}

