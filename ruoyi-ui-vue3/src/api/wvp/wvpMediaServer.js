import request from '@/utils/request'

// 查询媒体服务器列表
export function listWvpMediaServer(query) {
  return request({
    url: '/wvp/wvpMediaServer/list',
    method: 'get',
    params: query
  })
}

// 查询媒体服务器详细
export function getWvpMediaServer(id) {
  return request({
    url: '/wvp/wvpMediaServer/' + id,
    method: 'get'
  })
}

// 新增媒体服务器
export function addWvpMediaServer(data) {
  return request({
    url: '/wvp/wvpMediaServer',
    method: 'post',
    data: data
  })
}

// 修改媒体服务器
export function updateWvpMediaServer(data) {
  return request({
    url: '/wvp/wvpMediaServer',
    method: 'put',
    data: data
  })
}

// 删除媒体服务器
export function delWvpMediaServer(id) {
  return request({
    url: '/wvp/wvpMediaServer/' + id,
    method: 'delete'
  })
}

// 测试流媒体服务
export function checkMediaServer(data) {
  return request({
    url: '/wvp/wvpMediaServer/checkMediaServer',
    method: 'post',
    data: data
  })
}
