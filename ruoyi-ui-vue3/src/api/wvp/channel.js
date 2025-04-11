import request from '@/utils/request'

// 获取通道信息
export function getCommonChannel(id) {
    return request({
        url: `/api/common/channel/one/${id}`,
        method: 'get',
    })
}

// 获取通道信息列表
export function getIndustryCodeList() {
    return request({
        url: `/api/common/channel/industry/list`,
        method: 'get',
    })
}


// 获取通道类型列表
export function getDeviceTypeList() {
    return request({
        url: `/api/common/channel/type/list`,
        method: 'get',
    })
}

// 获取网络标识列表
export function getNetworkIdentificationTypeList() {
    return request({
        url: `/api/common/channel/network/identification/list`,
        method: 'get',
    })
}

// 重置通道
export function resetChannel(id) {
    return request({
        url: `/api/common/channel/reset/${id}`,
        method: 'post',
    })
}

// 修改通道信息
export function updateChannelData(data) {
    return request({
        url: `/api/common/channel/update`,
        method: 'post',
        data: data,
    })
}
