import request from '@/utils/request'

// 设备配置查询请求API接口
export function configDownloadApi(query) {
    return request({
        url: `/api/device/config/query/${query.deviceId}/${query.configType}`,
        method: 'get',
        params: query
    })
}
