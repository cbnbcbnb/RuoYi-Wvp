import request from '@/utils/request'

// 查询分组树
export function queryForTree(query) {
    return request({
        url: `/api/group/tree/list`,
        method: 'get',
        params: query
    })
}
