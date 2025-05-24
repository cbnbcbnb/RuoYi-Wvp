<p align="center">
	<img width="200" alt="logo" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/16/019d3685191040109b872d0802157368.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">RuoYi-Wvp</h1>
<h4 align="center">基于ruoyi-vue的流媒体平台，开箱即用、完全开源、使用MIT许可协议</h4>
<p align="center">
	<a href="https://gitee.com/xiaochemgzi/RuoYi-Wvp"><img width="40" height="20" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/59cbb8f48ba74ea78b7cec0a3b705410.png"></a>
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

# 我的开源项目

* [ruoyi-wvp](https://gitee.com/xiaochemgzi/RuoYi-Wvp)  基于ruoyi-vue的流媒体平台。
* [电子签章系统](https://gitee.com/tangwenzhaoaini/ruoyi-sign)  基于SpringBoot+Vue+Flowable前后端分离的电子签章系统。
* [RuoYi-Vue-Tenant](https://gitee.com/tangwenzhaoaini/ruo-yi-vue-tenant)  基于RuoYi-Vue的多租户管理平台。
* [RuoYi-Vue-flowable](https://gitee.com/tangwenzhaoaini/RuoYi-Vue-flowable)  基于RuoYi-Vue + flowable 的工作流管理平台。
* [RuoYi-Vue-Flowable-Tenant](https://gitee.com/tangwenzhaoaini/ruo-yi-vue-flowable-tenant)  基于RuoYi-Vue + flowable 的多租户工作流管理平台。
* [ruoyi-iot](https://gitee.com/xiaochemgzi/ruoyi-iot)  基于SpringBoot+Vue3前后端分离的Java物联网平台。
* [rtsp视频分析系统](https://gitee.com/xiaochemgzi/rtsp-video-analysis-system)  基于SpringBoot+Vue前后端分离的rtsp视频分析系统。
* [口罩分析流媒体服务器](https://gitee.com/xiaochemgzi/rtsp-ai)  基于SpringBoot+Vue前后端分离的口罩识别系统。

## 开源版和星球版功能区别

| 功能                | 开源版     | 星球版                                                                                                                                                                    |
|-------------------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 原若依全部功能           | 支持      | 支持                                                                                                                                                                     |
| 国标设备              | 支持/新增加部门权限分配设备     | 支持/新增加部门权限分配设备                                                                                                                                                         |
| 云端录像              | 支持      | 支持                                                                                                                                                                     |
| 推流列表              | 支持      | 支持                                                                                                                                                                     |
| 拉流列表              | 支持      | 支持                                                                                                                                                                     |
| 国标级联              | 支持      | 支持                                                                                                                                                                     |
| 录像计划              | 支持      | 支持                                                                                                                                                                     |
| 行政分组              | 支持      | 支持                                                                                                                                                                     |
| 通道管理              | 支持      | 支持                                                                                                                                                                     |
| 节点管理              | 支持      | 支持新增zml和删除                                                                                                                                                             |
| 分屏监控              | 简单的分屏监控 | 简单的分屏监控（工作台是完整的分屏监）                                                                                                                                                    |
| onvif协议           | 不支持     | 新增加部门权限分配设备<br/>设备发现：内网环境下可一键扫描并查看所有开启ONVIF协议的设备信息，实现高效集中管控<br/>设备嗅探：通过IP地址与账号密码自动探测设备，快速获取设备信息并启用实时直播功能。<br/>设备管理：实现参数配置及实时视频点播，简化多品牌设备管控<br/> 云台功能：实现绝对位置移动、连续移动、预置点 |
| isup协议            | 不支持     | 新增加部门权限分配设备。 设备上线、设备状态、设备管理、视频点播、云台控制                                                                                                                                  |
| rtsp协议            | 不支持     | 新增加部门权限分配设备。设备新增、设备管理、视频点播                                                                                                                                             |
| 大屏可视化             | 不支持     | 实现大屏展示                                                                                                                                                                 |
| 工作台               | 不支持     | 实现4种协议在线分屏展示                                                                                                                                                           |
| 小程序               | 不支持     | 实现小程序端管理                                                                                                                                                               |
| zml和ruoyi-wvp分开部署 | 不支持     | 支持                                                                                                                                                                     |
| 新首页ui             | 不支持     | 支持                                                                                                                                                                     |
| rtsp获取设备录像 | 不支持 | 支持 |

## 前端源码

加qq群获取最新前端vue3代码

<p align="center">
 <img width="400" alt="logo" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/7e0678c3f21547f0a427ddca506eab17.jpg">
</p>

## 在线体验

演示地址：http://java.ry-wvp.xyz   <br />
账号：ry <br />
密码：123456 <br />

文档地址：http://doc.ry-wvp.xyz

## 国标演示图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/c11404f40b3344719c5e17055972e35b.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/9238d06790764f3b9317f7b0a9abd056.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/749121d82e4844c4827afaaaa5172af2.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/1752defdedd44aea9d4b94440c0a56cd.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/350dcf28536448349a8ab4927a9e192e.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/a383b8369edb421080168fea74e4e4f2.png"/></td>
    </tr>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/34c300506ce74302be2f5bd63fca270f.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/f0c4aa1e694c4282853ebcb304503e28.png"/></td>
    </tr>
	<tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/43d4a7c839a64916a89ce6146acb4db4.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/389dff88a839449483518868154c804c.png"/></td>
    </tr>	 
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/690c87e89f80463298d48136b99998bc.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/b276ace519b541eba6b05e640b450e44.png"/></td>
    </tr>
	<tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/1b0dca2be11a44bab60bed1f6fefb0a7.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/27211331ad6246699cb3019ba9c92a64.png"/></td>
    </tr>
	<tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/a832fa6d9a50413385cbd2ed1b700797.png"/></td>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/ae58f01bff6c49a4bad5d622490bede6.png"/></td>
    </tr>
</table>

## onvif演示图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/ff16b289ad6c47899da28490ce20dd5c.png"/></td>
    </tr>
</table>

## isup播放示例图
<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/24/8ac1339ac5584a2090f529f61da50093.png"/></td>
    </tr>
</table>

## rtsp播放示例图

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/24/e35fc83314c54b9a91eb6ddbe2185e7b.png"/></td>
    </tr>
</table>

## 大屏

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/c0c59e92d0c74a20a9b177af2332e6d3.png"/></td>
    </tr>
</table>

## 工作台

<table>
    <tr>
        <td><img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/07/16ae29a3eaa24471a061d7364b113ab8.png"/></td>
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

* 微信1: chenbai0511 备注：ruoyi-wvp
* 微信2: NYHHDWGZL  备注：ruoyi-wvp

<p align="center">
    <img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/a8663f16829b4871a94c9534a6dad894.jpg"/>
    <img width="200" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/4601cea6e8cc4df18124bfc1af715dc7.png"/>
</p>

## 付费社群

<img src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/21/d96d8285328e4ecdbd459018d5ab55c5.jpg"/>

收费是为了提供更好的服务，也是对作者更大的激励。加入星球的用户三天后可以私信我留下微信号，我会拉大家入群。加入三天内不满意可以直接自行推出,星球会直接退款给大家。

星球还提供了包括闭源的全功能。

## 特别致谢

- 感谢作者[夏楚](https://github.com/xia-chu) 开源了这么棒流媒体服务框架。
- 感谢作者[wvp](https://github.com/648540858/wvp-GB28181-pro) 开源了这么棒国标服务器框架。
- 感谢作者[若依](https://ruoyi.vip/) 开源了这么棒快速开发框架。

## 赞赏方式

ry-wvp 全面支持微信/支付宝赞赏,江山父老可以请作者喝杯☕️咖啡吗qwq

如果你感觉项目对你有帮助,可以扫码进行捐赠qwq

<img width="700" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/04/17/bcfef20f53ee49e8baf2559f97e85ffb.jpg"/>

