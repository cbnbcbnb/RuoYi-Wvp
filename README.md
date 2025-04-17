<p align="center">
	<img width="200" alt="logo" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/16/019d3685191040109b872d0802157368.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">RuoYi-Wvp</h1>
<h4 align="center">基于ruoyi-vue的流媒体平台，开箱即用、完全开源、使用MIT许可协议</h4>
<p align="center">
	<a href="https://gitee.com/y_project/RuoYi-Vue"><img src="https://img.shields.io/badge/RuoYi-v3.8.9-brightgreen.svg"></a>
	<a href="https://gitee.com/y_project/RuoYi-Vue/blob/master/LICENSE"><img src="https://img.shields.io/github/license/mashape/apistatus.svg"></a>
</p>

## 平台介绍

ruoyi-wvp是基于ruoyi-vue和wvp框架的全部开源的GB/T 28181-2016标准流媒体平台，保留版权的情况下可以用于商业项目。

## 概述

* ruoyi-wvp 是基于GB/T 28181-2016标准全部开源的流媒体平台,依托优秀的开源流媒体服务[ZLMediaKit](https://github.com/ZLMediaKit/ZLMediaKit) ,实现了高效、稳定的流媒体处理功能。
* 整合了优秀的开源框架 ruoyi-vue，提供了高效率的开发体验，通过代码生成器，用户可以一键生成前后端代码，极大地提升了开发效率。
* 支持通过国标 28181 协议将各类摄像头和录像机轻松接入平台，实现视频流的在线观看与分发。
* 支持加载动态权限菜单，多方式轻松权限控制,支持多终端认证系统。

## 技术栈

* 前端基于Vue3与Element-Plus构建高效优雅前端界面。
* 后端运用Spring Boot构建基础，结合Spring Security保障安全，辅以Redis缓存与Jwt认证，打造稳健高效服务。

## 内置功能

1.  原若依全部功能：原若依全部功能,包含用户管理、角色管理、部门管理及系统监控等。
2.  国标设备：国标设备完成注册后,平台自动展示设备详情,支持查看设备通道及便捷点播视频等多样化功能。
3.  云端录像：用户可轻松查看或下载国标设备所存储的云端录像视频内容。
4.  推流列表：清晰呈现推流及可推流设备通道信息,支持一键播放视频与便捷国标通道配置等操作。
5.  拉流列表：清晰呈现拉流及可拉流设备通道信息,支持一键播放视频与便捷国标通道配置等操作。
6.  国标级联：基于GB/T 28181-2016标准,可高效实现多视频监控系统间的网络连接与资源共享。
7.  录像计划：基于GB/T 28181-2016标准,可灵活配置录像时段,实现智能化存储管理。
8.  行政分组：提供系统或企业级管理平台中用于组织和管理设备、用户及权限的逻辑架构，通过分层分级设计提升管理效率与安全性。
9.  通道管理：与行政分组和业务分组深度关联,实现通道精细化和高效化管理,形成多维度的管理逻辑。
10. 节点管理：实时查看ZLMediaKit节点的状态、负载及资源分配详情。
11. 分屏监控：支持4/6/9分屏自由切换，实时掌控多区域画面，提升安防巡查效率。

## 非开源功能

1.  onvif设备发现：内网环境下可一键扫描并查看所有开启ONVIF协议的设备信息，实现高效集中管控。
2.  onvif设备嗅探：通过IP地址与账号密码自动探测设备，快速获取设备信息并启用实时直播功能。
3.  onvif设备管理：实现参数配置及实时视频点播，简化多品牌设备管控。

## 在线体验

演示地址：暂无演示地址  
文档地址：http://doc.ruoyi.vip

## 国标演示图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/c11404f40b3344719c5e17055972e35b.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/1cbcf0e6f257c7d3a063c0e3f2ff989e4b3.jpg"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-8074972883b5ba0622e13246738ebba237a.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-9f88719cdfca9af2e58b352a20e23d43b12.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-39bf2584ec3a529b0d5a3b70d15c9b37646.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-936ec82d1f4872e1bc980927654b6007307.png"/></td>
    </tr>
	<tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-b2d62ceb95d2dd9b3fbe157bb70d26001e9.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-d67451d308b7a79ad6819723396f7c3d77a.png"/></td>
    </tr>	 
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/5e8c387724954459291aafd5eb52b456f53.jpg"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/644e78da53c2e92a95dfda4f76e6d117c4b.jpg"/></td>
    </tr>
	<tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-8370a0d02977eebf6dbf854c8450293c937.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-49003ed83f60f633e7153609a53a2b644f7.png"/></td>
    </tr>
	<tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-d4fe726319ece268d4746602c39cffc0621.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-c195234bbcd30be6927f037a6755e6ab69c.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/b6115bc8c31de52951982e509930b20684a.jpg"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-5e4daac0bb59612c5038448acbcef235e3a.png"/></td>
    </tr>
</table>

## onvif演示图



## 授权协议

本项目自有代码使用宽松的MIT协议，在保留版权信息的情况下可以自由应用于各自商用、非商业的项目。 但是本项目也零碎的使用了一些其他的开源代码，在商用的情况下请自行替代或剔除； 由于使用本项目而产生的商业纠纷或侵权行为一概与本项目及开发者无关，请自行承担法律风险。 在使用本项目代码时，也应该在授权协议中同时表明本项目依赖的第三方库的协议。

## 联系方式

* 微信1: chenbai0511
* 微信2: NYHHDWGZL


