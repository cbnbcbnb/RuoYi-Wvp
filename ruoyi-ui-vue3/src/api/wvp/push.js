import request from '@/utils/request'

// 获取推流列表
export function listPush(query) {
    return request({
        url: `/api/push/list`,
        method: 'get',
        params: query
    })
}

// 添加推流信息
export function addPush(data) {
    return request({
        url: `/api/push/add`,
        method: 'post',
        data: data
    })
}

// 更新推流信息
export function updatePush(data) {
    return request({
        url: `/api/push/update`,
        method: 'post',
        data: data
    })
}

// 删除推流
export function removePush(id) {
    return request({
        url: `/api/push/remove/${id}`,
        method: 'post',
    })
}
