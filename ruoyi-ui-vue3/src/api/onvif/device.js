import request from '@/utils/request'

// 查询onvif 设备列表
export function listDevice(query) {
  return request({
    url: '/onvif/device/list',
    method: 'get',
    params: query
  })
}

// 查询onvif 设备详细
export function getDevice(id) {
  return request({
    url: '/onvif/device/' + id,
    method: 'get'
  })
}

// 新增onvif 设备
export function addDevice(data) {
  return request({
    url: '/onvif/device',
    method: 'post',
    data: data
  })
}

// 修改onvif 设备
export function updateDevice(data) {
  return request({
    url: '/onvif/device',
    method: 'put',
    data: data
  })
}

// 删除onvif 设备
export function delDevice(id) {
  return request({
    url: '/onvif/device/' + id,
    method: 'delete'
  })
}
