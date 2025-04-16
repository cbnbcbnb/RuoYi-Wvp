# 接入设备

## 1.国标28181设备接入
设备接入主要是需要在设备上配置28181上级也就是ruoyi-wvp的信息，只有信息一致的情况才可以注册成功。设备注册成功后打开国标管理->国标设备,可以看到新增加的设备；设备使用，
主要有以下字段需要配置：
1. sip->port:28181服务监听的端口
2. sip->domain:domain宜采用ID统一编码的前十位编码。
3. sip->id:28181服务ID
4. sip->password:28181服务密码
5. 配置信息在如下位置
![VuePress Logo](/images/device/1.png)
## 大华摄像头配置信息
![VuePress Logo](/images/device/2.png)
## 大华NVR配置信息
![VuePress Logo](/images/device/3.png)
## 宇视科技配置信息
![VuePress Logo](/images/device/4.png)
## 水星摄像头配置信息
![VuePress Logo](/images/device/5.png)
## 海康摄像头配置信息
![VuePress Logo](/images/device/6.png)
## 直播推流设备
这里以obs推流为例,很多无人机也是一样的,设置下推流地址就可以接入了
1. 从ruoyi-wvp获取推流地址, 选择节点管理菜单,查看要推流的节点;
![VuePress Logo](/images/device/7.png)
2. 拼接推流地址 得到的rtsp地址就是: rtsp://{流IP}:{RTSP PORT}/{app}/{stream} 得到的rtmp地址就是: rtsp://{流IP}:{RTMP PORT}/{app}/{stream} 其中流IP是设备可以连接到zlm的IP,端口是对应协议的端口号, app和stream自己定义就可以.
3. 增加推流鉴权信息 wvp默认开启推流鉴权,拼接好的地址是不能直接推送的,会被返回鉴权失败,参考推流规则
4. 推流成功后可以再推流列表中看到推流设备,可以播放 此方式只支持设备实时流的播放,无其他功能, 推流信息在推流结束后会自动移除,在列表里就看不到了,如果需要推流信息需要为设备配置国标编号,这样才可以作为wvp的一个永久通道存在.
## 接入非国标IPC设备或者其他流地址形式的设备
这类设备的接入主要通过拉流代理的方式接入,原理就是zlm主动像播放器一样拉取这个流缓存在自己服务器供其他人播放.可以解决源设备并发访问能力差的问题. 在拉流代理/添加代理后可以直接播放, 拉流代理也是同样只支持播放当前配置的流.
