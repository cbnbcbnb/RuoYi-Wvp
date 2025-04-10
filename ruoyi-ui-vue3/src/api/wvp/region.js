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
