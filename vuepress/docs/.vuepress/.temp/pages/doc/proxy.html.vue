<template><div><h1 id="拉流代理" tabindex="-1"><a class="header-anchor" href="#拉流代理"><span>拉流代理</span></a></h1>
<p><img src="/images/img/2.png" alt="VuePress Logo"></p>
<p>不是所有的摄像机都支持国标或者推流的，但是这些设备可以得到一个视频播放地址，通常为rtsp协议， 以大华为例：</p>
<div class="language-javascript" data-highlighter="prismjs" data-ext="js"><pre v-pre><code><span class="line"><span class="token literal-property property">rtsp</span><span class="token operator">:</span><span class="token operator">/</span><span class="token operator">/</span><span class="token punctuation">{</span>user<span class="token punctuation">}</span><span class="token operator">:</span><span class="token punctuation">{</span>passwd<span class="token punctuation">}</span>@<span class="token punctuation">{</span>ipc_ip<span class="token punctuation">}</span><span class="token operator">:</span><span class="token punctuation">{</span>rtsp_port<span class="token punctuation">}</span><span class="token operator">/</span>cam<span class="token operator">/</span>realmonitor<span class="token operator">?</span>channel<span class="token operator">=</span><span class="token number">1</span><span class="token operator">&amp;</span>subtype<span class="token operator">=</span><span class="token number">0</span></span>
<span class="line"></span></code></pre>
</div><p>可以得到这样一个流地址，可以直接用vlc进行播放，此时我们可以通过拉流代理功能将这个设备推送给其他国标平台了。 流程如下：</p>
<h2 id="添加代理" tabindex="-1"><a class="header-anchor" href="#添加代理"><span>添加代理</span></a></h2>
<p>拉流代理支持两种方式：</p>
<ol>
<li>ZLM中直接代理流，支持RTSP/RTMP，不支持转码；</li>
<li>借助ffmpeg完成拉转，可以通过修改ffmpeg拉转参数完成转码。
点击页面的“添加代理”，添加信息后保存即可，如果你需要共享推流信息到其他国标平台,那么你需要编辑/国标通道配置,配置国标编码.</li>
</ol>
<p>PS： ffmpeg默认模板不需修改，需要修改参数自行去ZLM配置文件中添加一个即可。</p>
</div></template>


