import request from '@/utils/request'

// 分页获取拉流代理
export function listProxy(query) {
    return request({
        url: `/api/proxy/list`,
        method: 'get',
        params: query
    })
}

// 获取ffmpeg.cmd模板
export function getFFmpegCMDs(query) {
    return request({
        url: `/api/proxy/ffmpeg_cmd/list`,
        method: 'get',
        params: query
    })
}

// 更新拉流代理
export function updateProxy(data) {
    return request({
        url: `/api/proxy/update`,
        method: 'post',
        data: data
    })
}

// 新增拉流代理
export function addProxy(data) {
    return request({
        url: `/api/proxy/add`,
        method: 'post',
        data: data
    })
}

// 删除拉流代理
export function deleteProxy(id) {
    return request({
        url: `/api/proxy/delete/${id}`,
        method: 'delete',
    })
}

// 停止拉流代理
export function stopProxy(id) {
    return request({
        url: `/api/proxy/stop/${id}`,
        method: 'post',
    })
}

// 启用代理
export function start(query) {
    return request({
        url: `/api/proxy/start`,
        method: 'get',
        params: query
    })
}
