# 快速开始

## 1.准备工作
- JDK >= 1.8
- MySQL >= 5.7
- Maven >= 3.0
- Redis >= 3.0
- ZLMediaKit 建议使用稳定版本

## 2.运行ZLMediaKit
- 参考[ZLMediaKit](https://docs.zlmediakit.com/zh/)

## 3.修改配置文件
- 修改application-druid.yml
```yml:no-line-numbers
spring:
    datasource:
        type: com.alibaba.druid.pool.DruidDataSource
        driverClassName: com.mysql.cj.jdbc.Driver
        druid:
            # 主库数据源
            master:
                url: jdbc:mysql://127.0.0.1:3306/ry-wvp?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowMultiQueries=true
                username: root
                password: 自己密码
```
- 修改application.yml
```yml:no-line-numbers
##zlm 默认服务器配置
media:
  id: zlmediakit-local
  # [必须修改] zlm服务器的内网IP
  ip: 127.0.0.1
  # [必须修改] zlm服务器的http.port
  http-port: 8092
  # [必选选] zlm服务器的hook.admin_params=secret
  secret: TWSYFgYJOQWB4ftgeYut8DW4wbs7pQnj
  # 启用多端口模式, 多端口模式使用端口区分每路流，兼容性更好。 单端口使用流的ssrc区分， 点播超时建议使用多端口测试
  rtp:
    # [可选] 是否启用多端口模式, 开启后会在portRange范围内选择端口用于媒体流传输
    enable: true
    # [可选] 在此范围内选择端口用于媒体流传输, 必须提前在zlm上配置该属性，不然自动配置此属性可能不成功
    port-range: 40000,40300 # 端口范围
    # [可选] 国标级联在此范围内选择端口发送媒体流,
    send-port-range: 40000,40300 # 端口范围
```
## 4.运行后端系统
- 前往Gitee下载页面[ruoyi-vue](https://doc.ruoyi.vip/)下载解压到工作目录
- 导入到IDEA中，菜单 File -> Open，选择下载的文件解压后的文件夹
- 创建数据库ry-wvp并导入数据脚本ry-wvp.sql
- 运行`RuoYiApplication.java`，启动项目
- 项目运行访问地址：http://localhost:8080
```java:no-line-numbers
(♥◠‿◠)ﾉﾞ  若依启动成功   ლ(´ڡ`ლ)ﾞ  
 .-------.       ____     __        
 |  _ _   \      \   \   /  /    
 | ( ' )  |       \  _. /  '       
 |(_ o _) /        _( )_ .'         
 | (_,_).' __  ___(_ o _)'          
 |  |\ \  |  ||   |(_,_)'         
 |  | \ `'   /|   `-'  /           
 |  |  \    /  \      /           
 ''-'   `'-'    `-..-'    
```
## 5.运行前端系统
```javascript:no-line-numbers
# 进入项目目录
cd ruoyi-ui-vue3

# 安装依赖
npm i --registry=https://registry.npmmirror.com

# 启动服务
npm run dev

# 构建测试环境 npm run build:stage
# 构建生产环境 npm run build:prod
# 前端访问地址 http://localhost:80
```
## 6.遇到问题
加联系方式
- 微信: chenbai0511 备注：`ruoyi-wvp`
- 微信: NYHHDWGZL 备注：`ruoyi-wvp`

