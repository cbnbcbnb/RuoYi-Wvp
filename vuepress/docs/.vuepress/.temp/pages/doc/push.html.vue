<template><div><h1 id="推流列表" tabindex="-1"><a class="header-anchor" href="#推流列表"><span>推流列表</span></a></h1>
<p><img src="/images/img/3.png" alt="VuePress Logo"></p>
<h2 id="功能说明" tabindex="-1"><a class="header-anchor" href="#功能说明"><span>功能说明</span></a></h2>
<p>系统支持三种图像输入方式，直播，<RouteLink to="/doc/proxy.md">拉流代理</RouteLink>，<RouteLink to="/doc/device.md">国标</RouteLink>,直播设备接入流程如下</p>
<ol>
<li>默认情况下系统收到推流信息后，列表中出现这条推流信息，如果你需要共享推流信息到其他国标平台,那么你需要编辑/国标通道配置,配置国标编码.</li>
<li>系统也支持推流前导入大量通道直接推送给上级，点击“下载模板”按钮，根据示例修改模板后，点击“通道导入”按钮导入通道数据.</li>
</ol>
<h2 id="推拉流鉴权规则" tabindex="-1"><a class="header-anchor" href="#推拉流鉴权规则"><span>推拉流鉴权规则</span></a></h2>
<p>为了保护服务器的系统默认开启推流鉴权（目前不支持关闭此功能）</p>
<h2 id="推流规则" tabindex="-1"><a class="header-anchor" href="#推流规则"><span>推流规则</span></a></h2>
<p>推流时需要携带推流鉴权的签名sign，sign=md5(pushKey),pushKey来自用户表，每个用户会有一个不同的pushKey. 例如app=test，stream=live，pushKey=1000，ip=127.0.0.1, port=10554 那么推流地址为：</p>
<div class="language-javascript" data-highlighter="prismjs" data-ext="js"><pre v-pre><code><span class="line"><span class="token literal-property property">rtsp</span><span class="token operator">:</span><span class="token operator">/</span><span class="token operator">/</span><span class="token number">127.0</span><span class="token number">.0</span><span class="token number">.1</span><span class="token operator">:</span><span class="token number">10554</span><span class="token operator">/</span>test<span class="token operator">/</span>live<span class="token operator">?</span>sign<span class="token operator">=</span>a9b7ba70783b617e9998dc4dd82eb3c5</span>
<span class="line"></span></code></pre>
</div><p>支持推流时自定义播放鉴权Id，参数名为callId，此时sign=md5(callId_pushKey) 例如app=test，stream=live，pushKey=1000，callId=12345678, ip=127.0.0.1, port=10554 那么推流地址为：</p>
<div class="language-javascript" data-highlighter="prismjs" data-ext="js"><pre v-pre><code><span class="line"><span class="token literal-property property">rtsp</span><span class="token operator">:</span><span class="token operator">/</span><span class="token operator">/</span><span class="token number">127.0</span><span class="token number">.0</span><span class="token number">.1</span><span class="token operator">:</span><span class="token number">10554</span><span class="token operator">/</span>test<span class="token operator">/</span>live<span class="token operator">?</span>callId<span class="token operator">=</span><span class="token number">12345678</span><span class="token operator">&amp;</span>sign<span class="token operator">=</span>c8e6e01dde2d60c66dcea8d2498ffef1</span>
<span class="line"></span></code></pre>
</div><h2 id="播放规则" tabindex="-1"><a class="header-anchor" href="#播放规则"><span>播放规则</span></a></h2>
<p>默认情况播放不需要鉴权，但是如果推流时携带了callId，那么播放时必须携带callId 例如app=test，stream=live，无callId, ip=127.0.0.1, port=10554 那么播放地址为：</p>
<div class="language-javascript" data-highlighter="prismjs" data-ext="js"><pre v-pre><code><span class="line"><span class="token literal-property property">rtsp</span><span class="token operator">:</span><span class="token operator">/</span><span class="token operator">/</span><span class="token number">127.0</span><span class="token number">.0</span><span class="token number">.1</span><span class="token operator">:</span><span class="token number">10554</span><span class="token operator">/</span>test<span class="token operator">/</span>live</span>
<span class="line"></span></code></pre>
</div><p>例如app=test，stream=live，callId=12345678, ip=127.0.0.1, port=10554 那么播放地址为：</p>
<div class="language-javascript" data-highlighter="prismjs" data-ext="js"><pre v-pre><code><span class="line"><span class="token literal-property property">rtsp</span><span class="token operator">:</span><span class="token operator">/</span><span class="token operator">/</span><span class="token number">127.0</span><span class="token number">.0</span><span class="token number">.1</span><span class="token operator">:</span><span class="token number">10554</span><span class="token operator">/</span>test<span class="token operator">/</span>live<span class="token operator">?</span>callId<span class="token operator">=</span><span class="token number">12345678</span></span>
<span class="line"></span></code></pre>
</div></div></template>


