import request from '@/utils/request'

// 查询分组树
export function queryForTree(query) {
    return request({
        url: `/api/group/tree/list`,
        method: 'get',
        params: query
    })
}

// 更新分组
export function updateGroup(data) {
    return request({
        url: `/api/group/update`,
        method: 'post',
        data: data
    })
}

// 添加分组
export function addGroup(data) {
    return request({
        url: `/api/group/add`,
        method: 'post',
        data: data
    })
}

// 删除分组
export function deleteGroup(id) {
    return request({
        url: `/api/group/delete/${id}`,
        method: 'delete',
    })
}
