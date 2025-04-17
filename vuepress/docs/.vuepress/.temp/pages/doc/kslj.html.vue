<template><div><h1 id="快速开始" tabindex="-1"><a class="header-anchor" href="#快速开始"><span>快速开始</span></a></h1>
<h2 id="_1-准备工作" tabindex="-1"><a class="header-anchor" href="#_1-准备工作"><span>1.准备工作</span></a></h2>
<ul>
<li>JDK &gt;= 1.8</li>
<li>MySQL &gt;= 5.7</li>
<li>Maven &gt;= 3.0</li>
<li>Redis &gt;= 3.0</li>
<li>ZLMediaKit 建议使用稳定版本</li>
</ul>
<h2 id="_2-运行zlmediakit" tabindex="-1"><a class="header-anchor" href="#_2-运行zlmediakit"><span>2.运行ZLMediaKit</span></a></h2>
<ul>
<li>参考<a href="https://docs.zlmediakit.com/zh/" target="_blank" rel="noopener noreferrer">ZLMediaKit</a></li>
</ul>
<h2 id="_3-修改配置文件" tabindex="-1"><a class="header-anchor" href="#_3-修改配置文件"><span>3.修改配置文件</span></a></h2>
<ul>
<li>修改application-druid.yml</li>
</ul>
<div class="language-yaml" data-highlighter="prismjs" data-ext="yml"><pre v-pre><code><span class="line"><span class="token key atrule">spring</span><span class="token punctuation">:</span></span>
<span class="line">    <span class="token key atrule">datasource</span><span class="token punctuation">:</span></span>
<span class="line">        <span class="token key atrule">type</span><span class="token punctuation">:</span> com.alibaba.druid.pool.DruidDataSource</span>
<span class="line">        <span class="token key atrule">driverClassName</span><span class="token punctuation">:</span> com.mysql.cj.jdbc.Driver</span>
<span class="line">        <span class="token key atrule">druid</span><span class="token punctuation">:</span></span>
<span class="line">            <span class="token comment"># 主库数据源</span></span>
<span class="line">            <span class="token key atrule">master</span><span class="token punctuation">:</span></span>
<span class="line">                <span class="token key atrule">url</span><span class="token punctuation">:</span> jdbc<span class="token punctuation">:</span>mysql<span class="token punctuation">:</span>//127.0.0.1<span class="token punctuation">:</span>3306/ry<span class="token punctuation">-</span>wvp<span class="token punctuation">?</span>useUnicode=true<span class="token important">&amp;characterEncoding=utf8&amp;zeroDateTimeBehavior=convertToNull&amp;useSSL=true&amp;serverTimezone=GMT%2B8&amp;rewriteBatchedStatements=true&amp;allowMultiQueries=true</span></span>
<span class="line">                <span class="token key atrule">username</span><span class="token punctuation">:</span> root</span>
<span class="line">                <span class="token key atrule">password</span><span class="token punctuation">:</span> 自己密码</span>
<span class="line"></span></code></pre>
</div><ul>
<li>修改application.yml</li>
</ul>
<div class="language-yaml" data-highlighter="prismjs" data-ext="yml"><pre v-pre><code><span class="line"><span class="token comment">##zlm 默认服务器配置</span></span>
<span class="line"><span class="token key atrule">media</span><span class="token punctuation">:</span></span>
<span class="line">  <span class="token key atrule">id</span><span class="token punctuation">:</span> zlmediakit<span class="token punctuation">-</span>local</span>
<span class="line">  <span class="token comment"># [必须修改] zlm服务器的内网IP</span></span>
<span class="line">  <span class="token key atrule">ip</span><span class="token punctuation">:</span> 127.0.0.1</span>
<span class="line">  <span class="token comment"># [必须修改] zlm服务器的http.port</span></span>
<span class="line">  <span class="token key atrule">http-port</span><span class="token punctuation">:</span> <span class="token number">8092</span></span>
<span class="line">  <span class="token comment"># [必选选] zlm服务器的hook.admin_params=secret</span></span>
<span class="line">  <span class="token key atrule">secret</span><span class="token punctuation">:</span> TWSYFgYJOQWB4ftgeYut8DW4wbs7pQnj</span>
<span class="line">  <span class="token comment"># 启用多端口模式, 多端口模式使用端口区分每路流，兼容性更好。 单端口使用流的ssrc区分， 点播超时建议使用多端口测试</span></span>
<span class="line">  <span class="token key atrule">rtp</span><span class="token punctuation">:</span></span>
<span class="line">    <span class="token comment"># [可选] 是否启用多端口模式, 开启后会在portRange范围内选择端口用于媒体流传输</span></span>
<span class="line">    <span class="token key atrule">enable</span><span class="token punctuation">:</span> <span class="token boolean important">true</span></span>
<span class="line">    <span class="token comment"># [可选] 在此范围内选择端口用于媒体流传输, 必须提前在zlm上配置该属性，不然自动配置此属性可能不成功</span></span>
<span class="line">    <span class="token key atrule">port-range</span><span class="token punctuation">:</span> <span class="token number">40000</span><span class="token punctuation">,</span><span class="token number">40300</span> <span class="token comment"># 端口范围</span></span>
<span class="line">    <span class="token comment"># [可选] 国标级联在此范围内选择端口发送媒体流,</span></span>
<span class="line">    <span class="token key atrule">send-port-range</span><span class="token punctuation">:</span> <span class="token number">40000</span><span class="token punctuation">,</span><span class="token number">40300</span> <span class="token comment"># 端口范围</span></span>
<span class="line"></span></code></pre>
</div><h2 id="_4-运行后端系统" tabindex="-1"><a class="header-anchor" href="#_4-运行后端系统"><span>4.运行后端系统</span></a></h2>
<ul>
<li>前往Gitee下载页面<a href="https://doc.ruoyi.vip/" target="_blank" rel="noopener noreferrer">ruoyi-vue</a>下载解压到工作目录</li>
<li>导入到IDEA中，菜单 File -&gt; Open，选择下载的文件解压后的文件夹</li>
<li>创建数据库ry-wvp并导入数据脚本ry-wvp.sql</li>
<li>运行<code v-pre>RuoYiApplication.java</code>，启动项目</li>
<li>项目运行访问地址：http://localhost:8080</li>
</ul>
<div class="language-java" data-highlighter="prismjs" data-ext="java"><pre v-pre><code><span class="line"><span class="token punctuation">(</span>♥◠‿◠<span class="token punctuation">)</span>ﾉﾞ  若依启动成功   ლ<span class="token punctuation">(</span>´ڡ`ლ<span class="token punctuation">)</span>ﾞ  </span>
<span class="line"> <span class="token punctuation">.</span>-<span class="token operator">--</span><span class="token operator">--</span><span class="token operator">--</span><span class="token punctuation">.</span>       ____     __        </span>
<span class="line"> <span class="token operator">|</span>  _ _   \      \   \   <span class="token operator">/</span>  <span class="token operator">/</span>    </span>
<span class="line"> <span class="token operator">|</span> <span class="token punctuation">(</span> ' <span class="token punctuation">)</span>  <span class="token operator">|</span>       \  _<span class="token punctuation">.</span> <span class="token operator">/</span>  '       </span>
<span class="line"> <span class="token operator">|</span><span class="token punctuation">(</span>_ o _<span class="token punctuation">)</span> <span class="token operator">/</span>        <span class="token function">_</span><span class="token punctuation">(</span> <span class="token punctuation">)</span>_ <span class="token punctuation">.</span>'         </span>
<span class="line"> <span class="token operator">|</span> <span class="token punctuation">(</span>_<span class="token punctuation">,</span>_<span class="token punctuation">)</span><span class="token punctuation">.</span>' __  <span class="token function">___</span><span class="token punctuation">(</span>_ o _<span class="token punctuation">)</span>'          </span>
<span class="line"> <span class="token operator">|</span>  <span class="token operator">|</span>\ \  <span class="token operator">|</span>  <span class="token operator">||</span>   <span class="token operator">|</span><span class="token punctuation">(</span>_<span class="token punctuation">,</span>_<span class="token punctuation">)</span>'         </span>
<span class="line"> <span class="token operator">|</span>  <span class="token operator">|</span> \ `'   <span class="token operator">/</span><span class="token operator">|</span>   `<span class="token operator">-</span>'  <span class="token operator">/</span>           </span>
<span class="line"> <span class="token operator">|</span>  <span class="token operator">|</span>  \    <span class="token operator">/</span>  \      <span class="token operator">/</span>           </span>
<span class="line"> '<span class="token char">'-'</span>   `<span class="token char">'-'</span>    `<span class="token operator">-</span><span class="token punctuation">.</span><span class="token punctuation">.</span>-'    </span>
<span class="line"></span></code></pre>
</div><h2 id="_5-运行前端系统" tabindex="-1"><a class="header-anchor" href="#_5-运行前端系统"><span>5.运行前端系统</span></a></h2>
<div class="language-javascript" data-highlighter="prismjs" data-ext="js"><pre v-pre><code><span class="line"># 进入项目目录</span>
<span class="line">cd ruoyi<span class="token operator">-</span>ui<span class="token operator">-</span>vue3</span>
<span class="line"></span>
<span class="line"># 安装依赖</span>
<span class="line">npm i <span class="token operator">--</span>registry<span class="token operator">=</span>https<span class="token operator">:</span><span class="token operator">/</span><span class="token operator">/</span>registry<span class="token punctuation">.</span>npmmirror<span class="token punctuation">.</span>com</span>
<span class="line"></span>
<span class="line"># 启动服务</span>
<span class="line">npm run dev</span>
<span class="line"></span>
<span class="line"># 构建测试环境 npm run build<span class="token operator">:</span>stage</span>
<span class="line"># 构建生产环境 npm run build<span class="token operator">:</span>prod</span>
<span class="line"># 前端访问地址 http<span class="token operator">:</span><span class="token operator">/</span><span class="token operator">/</span>localhost<span class="token operator">:</span><span class="token number">80</span></span>
<span class="line"></span></code></pre>
</div><h2 id="_6-遇到问题" tabindex="-1"><a class="header-anchor" href="#_6-遇到问题"><span>6.遇到问题</span></a></h2>
<p>加联系方式</p>
<ul>
<li>微信: chenbai0511 备注：<code v-pre>ruoyi-wvp</code></li>
<li>微信: NYHHDWGZL 备注：<code v-pre>ruoyi-wvp</code></li>
</ul>
</div></template>


