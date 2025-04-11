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

