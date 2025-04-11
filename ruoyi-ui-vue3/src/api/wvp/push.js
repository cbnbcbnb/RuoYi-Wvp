import request from '@/utils/request'

// 获取推流列表
export function listPush(query) {
    return request({
        url: `/api/push/list`,
        method: 'get',
        params: query
    })
}
