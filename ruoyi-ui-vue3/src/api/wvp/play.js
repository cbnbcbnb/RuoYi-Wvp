import request from '@/utils/request'

// 停止点播
export function playStop(deviceId, channelId) {
    return request({
        url: `/api/play/stop/${deviceId}/${channelId}`,
        method: 'get',
    })
}
