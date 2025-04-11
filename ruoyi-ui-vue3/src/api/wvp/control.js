import request from '@/utils/request'

// 录像控制命令API接口
export function recordApi(query) {
    return request({
        url: `/api/device/control/record/${query.deviceId}/${query.recordCmdStr}`,
        method: 'get',
        params: query
    })
}

// 报警布防/撤防命令API接口
export function guardApi(query) {
    return request({
        url: `/api/device/control/guard/${query.deviceId}/${query.guardCmdStr}`,
        method: 'get',
    })
}
