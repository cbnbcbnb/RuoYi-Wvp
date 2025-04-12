import request from '@/utils/request'

// 获取所属的行政区划下的行政区划
export function getAllChild(query) {
    return request({
        url: `/api/region/base/child/list`,
        method: 'get',
        params: query
    })
}

// 查询区域
export function queryForTree(query) {
    return request({
        url: `/api/region/tree/list`,
        method: 'get',
        params: query
    })
}

// 更新区域
export function updateRegion(data) {
    return request({
        url: `/api/region/update`,
        method: 'post',
        data: data
    })
}

// 添加区域
export function addRegion(data) {
    return request({
        url: `/api/region/add`,
        method: 'post',
        data: data
    })
}

// 删除区域
export function deleteRegion(id) {
    return request({
        url: `/api/region/delete/${id}`,
        method: 'delete',
    })
}
