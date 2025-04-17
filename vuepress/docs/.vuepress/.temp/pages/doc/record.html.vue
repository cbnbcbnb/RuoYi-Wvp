<template><div><h1 id="云端录像" tabindex="-1"><a class="header-anchor" href="#云端录像"><span>云端录像</span></a></h1>
<p><img src="/images/img/1.png" alt="VuePress Logo"></p>
<p>云端录像是对录制在zlm服务下的录像文件的管理，录像的文件路径默认在ZLM/www/record下。</p>
<ol>
<li>国标设备是否录像: 可以再系统的配置中user-settings.record-sip设置为true那么每次点播以及录像回放都会录像;</li>
<li>推流设备是否录像: 可以再系统的配置中user-settings.record-push-live设置为true;</li>
<li>拉流代理的是否录像: 在添加和编辑拉流代理时可以指定, 每次点播都会进行录像;</li>
<li>录像文件存储路径配置: 可以修改media.record-path来修改录像路径,但是如果有旧的录像文件,请不要迁移,因为数据库记录了每一个录像的绝对路径,一旦修改会造成找到文件,无法定时移除以及播放</li>
<li>录像保存时间: 可以修改media.record-day来修改录像保存时间,单位是天;</li>
</ol>
</div></template>


