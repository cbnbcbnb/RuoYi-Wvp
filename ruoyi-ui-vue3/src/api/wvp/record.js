import request from '@/utils/request'

// 查询云端录像
export function openRtpServer(query) {
    return request({
        url: `/api/cloud/record/list`,
        method: 'get',
        params: query
    })
}

// 获取播放地址
export function getPlayUrlPath(query) {
    return request({
        url: `/api/cloud/record/play/path`,
        method: 'get',
        params: query
    })
}

// 查询录制计划列表
export function listRecord(query) {
    return request({
        url: `/api/record/plan/query`,
        method: 'get',
        params: query
    })
}

// 新增录制计划
export function addRecord(data) {
    return request({
        url: `/api/record/plan/add`,
        method: 'post',
        data: data
    })
}

// 更新录制计划
export function updateRecord(data) {
    return request({
        url: `/api/record/plan/update`,
        method: 'post',
        data: data
    })
}

// 获取录制计划
export function getRecord(id) {
    return request({
        url: `/api/record/plan/get/${id}`,
        method: 'get',
    })
}

// 删除录制计划
export function deleteRecord(id) {
    return request({
        url: `/api/record/plan/delete/${id}`,
        method: 'delete',
    })
}

// 查询通道列表
export function listPlanRecord(query) {
    return request({
        url: `/api/record/plan/channel/list`,
        method: 'get',
        params: query
    })
}

// 通道关联录制计划
export function link(data) {
    return request({
        url: `/api/record/plan/link`,
        method: 'post',
        data: data
    })
}
