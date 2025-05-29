<p align="center">
	<img width="200" alt="logo" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/c271a2c48ffc4b1eac47985402641109.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">RuoYi-Wvp</h1>
<h4 align="center">基于ruoyi-vue的流媒体平台，开箱即用、完全开源、使用MIT许可协议</h4>
<p align="center">
	<a href="https://gitee.com/xiaochemgzi/RuoYi-Wvp"><img width="40" height="20" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/59cbb8f48ba74ea78b7cec0a3b705410.png"></a>
</p>

## 平台介绍

ruoyi-wvp是基于ruoyi-vue和wvp框架的全部开源的GB/T 28181-2016标准流媒体平台,支持gb28181-2016协议、onvif协议、rtsp协议、isup协议4种协议，保留版权的情况下可以用于商业项目。

## 概述

* ruoyi-wvp 是基于GB/T 28181-2016标准全部开源的流媒体平台,依托优秀的开源流媒体服务[ZLMediaKit](https://github.com/ZLMediaKit/ZLMediaKit) ,实现了高效、稳定的流媒体处理功能。
* 感谢goview开源项目，ruoyi-wvp前端基于goview进行开发自定义大屏。
* 整合了优秀的开源框架 ruoyi-vue，提供了高效率的开发体验，通过代码生成器，用户可以一键生成前后端代码，极大地提升了开发效率。
* 支持通过国标 28181 协议将各类摄像头和录像机轻松接入平台，实现视频流的在线观看与分发。
* 支持加载动态权限菜单，多方式轻松权限控制,支持多终端认证系统。

## 技术栈

* 前端基于Vue3与Element-Plus构建高效优雅前端界面。
* 后端运用Spring Boot构建基础，结合Spring Security保障安全，辅以Redis缓存与Jwt认证，打造稳健高效服务。

## 我的开源项目

* [ruoyi-wvp](https://gitee.com/xiaochemgzi/RuoYi-Wvp)  基于ruoyi-vue的流媒体平台。
* [电子签章系统](https://gitee.com/tangwenzhaoaini/ruoyi-sign)  基于SpringBoot+Vue+Flowable前后端分离的电子签章系统。
* [RuoYi-Vue-Tenant](https://gitee.com/tangwenzhaoaini/ruo-yi-vue-tenant)  基于RuoYi-Vue的多租户管理平台。
* [RuoYi-Vue-flowable](https://gitee.com/tangwenzhaoaini/RuoYi-Vue-flowable)  基于RuoYi-Vue + flowable 的工作流管理平台。
* [RuoYi-Vue-Flowable-Tenant](https://gitee.com/tangwenzhaoaini/ruo-yi-vue-flowable-tenant)  基于RuoYi-Vue + flowable 的多租户工作流管理平台。
* [ruoyi-iot](https://gitee.com/xiaochemgzi/ruoyi-iot)  基于SpringBoot+Vue3前后端分离的Java物联网平台。
* [rtsp视频分析系统](https://gitee.com/xiaochemgzi/rtsp-video-analysis-system)  基于SpringBoot+Vue前后端分离的rtsp视频分析系统。
* [口罩分析流媒体服务器](https://gitee.com/xiaochemgzi/rtsp-ai)  基于SpringBoot+Vue前后端分离的口罩识别系统。

## 开源版和星球版功能区别

| 功能                | 开源版     | 星球版                                                                                                                                                          |
|-------------------|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 原若依全部功能           | 支持      | 支持                                                                                                                                                           | 
| 国标设备              | 支持      | 新增加部门权限分配设备                                                                                                                                                  | 
| 云端录像              | 支持      | 支持                                                                                                                                                           | 
| 推流列表              | 支持      | 支持                                                                                                                                                           | 
| 拉流列表              | 支持      | 支持                                                                                                                                                           | 
| 国标级联              | 支持      | 支持                                                                                                                                                           | 
| 录像计划              | 支持      | 支持                                                                                                                                                           | 
| 行政分组              | 支持      | 支持                                                                                                                                                           | 
| 通道管理              | 支持      | 支持                                                                                                                                                           | 
| 节点管理              | 支持      | 支持                                                                                                                                                   | 
| 分屏监控              | 简单的分屏监控 | 简单的分屏监控（工作台是完整的分屏监）                                                                                                                                          | 
| onvif协议           | 不支持     | 新增加部门权限分配设备<br/>设备发现：内网环境下可一键扫描并查看所有开启ONVIF协议的设备信息，实现高效集中管控<br/>设备嗅探：通过IP地址与账号密码自动探测设备，快速获取设备信息并启用实时直播功能。<br/>设备管理：实现参数配置及实时视频点播，简化多品牌设备管控<br/> 云台功能：实现绝对位置移动、连续移动、预置点 | 
| isup协议            | 不支持 | 新增加部门权限分配设备。 设备上线、设备状态、设备管理、视频点播、云台控制                                                                                                                        | 
| rtsp协议            | 不支持 | 新增加部门权限分配设备。设备新增、设备管理、视频点播                                                                                                                                   | 
| 大屏可视化             | 不支持 | 实现大屏展示                                                                                                                                                       | 
| 工作台               | 不支持 | 实现4种协议在线分屏展示                                                                                                                                                 | 
| 小程序               | 不支持 | 实现小程序端管理                                                                                                                                                     |
| zml和ruoyi-wvp分开部署 | 不支持 | 支持                                                                                                                                                           |
| 新首页ui             | 不支持 | 支持                                                                                                                                                           |
| rtsp获取设备录像        | 不支持 | 支持                                                                                                                                                           |
| 设备电子地图            | 不支持 | 支持                                                                                                                                                           |
| goview自定义大屏       | 不支持 | 支持                                                                                                                                                           |

## 前端源码

加qq群获取最新前端vue3代码

<p align="center">
 <img width="200" alt="logo" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/310918b382b848d1a6041f677c33f761.png">
</p>

## 在线体验

演示地址：http://java.ry-wvp.xyz   <br />
账号：ry <br />
密码：123456 <br />

文档地址：http://doc.ry-wvp.xyz

## 国标演示图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/bcc5b5a4f2e94942a276686143d696a0.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/78ec5124ec014bb3a8c5281789ddf53f.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/29684077a42043c797ed6efbb65d062b.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/3ed942787acb47fd88cd0a61b3fe83a4.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/bacc4d46ca574e75ad36de17420c61f3.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/64519d4abe7a4e6abd0bcf769200783f.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/72dbff1e712746eaa044ed79891e221f.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/5c260debcae040d499f0c850ffede039.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/19f242c2bd944e15b8f349afe8802af5.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/48774ce0f1554dddaf1ef2aa164a6462.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/7496c1a202af475097016ad7315299be.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/3bb2c70f3b064241a08e852eb607f7b3.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/8475ae2f54da49ae9d323f4427eadbd7.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/c37dba0815d0459fb8f3312bb8925114.png"/></td>
    </tr>
</table>

## onvif演示图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/f88ee276445a46629deaa21ab0e51f66.png"/></td>
    </tr>
</table>

## isup播放示例图
<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/eb39dd8be997443192d861c8f2e6289e.png"/></td>
    </tr>
</table>

## rtsp播放示例图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/c4ae80af45c74682b5a03d33cdc7e445.png"/></td>
    </tr>
</table>

## 大屏（普通）

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/c0c59e92d0c74a20a9b177af2332e6d3.png"/></td>
    </tr>
</table>

## goview大屏（自定义）

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/28/b673275ff8644e21a83ae619f7660025.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/28/372278fbf7c64dc7b8394c4107a54778.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/28/208b7780f8374ca1b7737aaa44003b4c.png"/></td>
    </tr>
</table>

## 电子地图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/28/4045112673674c16aed239aaee63f645.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/28/b78d83cbc19f40c0af3467fdb8588f40.png"/></td>
    </tr>
</table>

## 工作台

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/5abb2f92dd284b629bd7b66b10a527d1.png"/></td>
    </tr>
</table>

## 小程序

<table>
    <tr>
        <td><img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/7f4b35186a2041b1a04f4c71a534a29d.png"/></td>
        <td><img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/fee62e3df1a8458f810a7818561a7530.png"/></td>
    </tr>
    <tr>
        <td><img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/c7f62a49119f4f7cb44fc9afb2e77107.png"/></td>
        <td><img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/77a2f2dc4fc141c6918fe9f5df129605.png"/></td>
    </tr>
</table>

## 授权协议

本项目自有代码使用宽松的MIT协议，在保留版权信息的情况下可以自由应用于各自商用、非商业的项目。 但是本项目也零碎的使用了一些其他的开源代码，在商用的情况下请自行替代或剔除； 由于使用本项目而产生的商业纠纷或侵权行为一概与本项目及开发者无关，请自行承担法律风险。 在使用本项目代码时，也应该在授权协议中同时表明本项目依赖的第三方库的协议。

## 联系方式

* 微信1: ruoyi-wvp888 备注：ruoyi-wvp
* 微信2: qsh-network  备注：ruoyi-wvp

<p align="center">
    <img width="175" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/b044fce6e12a494499a58a3727e3118d.png"/>
    <img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/5dd0b0db51fc43878a03831f2ca9b546.jpg"/>
</p>

## 付费社群

<img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/21/d96d8285328e4ecdbd459018d5ab55c5.jpg"/>

收费是为了提供更好的服务，也是对作者更大的激励。加入星球的用户三天后可以私信我留下微信号，我会拉大家入群。加入三天内不满意可以直接自行推出,星球会直接退款给大家。

星球还提供了包括闭源的全功能。

## 特别致谢

- 感谢作者[夏楚](https://github.com/xia-chu) 开源了这么棒流媒体服务框架。
- 感谢作者[wvp](https://github.com/648540858/wvp-GB28181-pro) 开源了这么棒国标服务器框架。
- 感谢作者[若依](https://ruoyi.vip/) 开源了这么棒快速开发框架。
- 感谢作者[go-view](https://gitee.com/dromara/go-view) 开源了这么棒的大屏应用框架。

## 赞赏方式

ry-wvp 全面支持微信/支付宝赞赏,江山父老可以请作者喝杯☕️咖啡吗qwq

如果你感觉项目对你有帮助,可以扫码进行捐赠qwq

<img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/0e45f14f73f24e5b8f8c9441415c4d3a.jpg"/>

