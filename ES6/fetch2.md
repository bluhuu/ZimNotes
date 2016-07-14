<div class="post">
		<h1 class="postTitle">
			<a id="cb_post_title_url" class="postTitle2" href="http://www.cnblogs.com/parry/p/using_fetch_in_nodejs.html" target="_blank">在 JS 中使用 fetch 更加高效地进行网络请求</a>
		</h1>
		<div class="clear"></div>
		<div class="postBody">
			<div id="cnblogs_post_body" class="cnblogs-markdown"><p>在前端快速发展地过程中，为了契合更好的设计模式，产生了 fetch 框架，此文将简要介绍下 fetch 的基本使用。<br>
我的源博客地址：<a href="http://blog.parryqiu.com/2016/03/02/using_fetch_in_nodejs/" class="uri" target="_blank">http://blog.parryqiu.com/2016/03/02/using_fetch_in_nodejs/</a></p>
<p>在 AJAX 时代，进行请求 API 等网络请求都是通过 <a href="http://www.w3school.com.cn/xml/xml_http.asp" target="_blank">XMLHttpRequest</a> 或者封装后的框架进行网络请求。<br>
现在产生的 <a href="https://github.com/github/fetch" target="_blank">fetch</a> 框架简直就是为了提供更加强大、高效的网络请求而生，虽然在目前会有一点浏览器兼容的问题，但是当我们进行 Hybrid App 开发的时候，如我之前介绍的 <a href="http://blog.parryqiu.com/categories/App-%E5%BC%80%E5%8F%91/Hybrid-App/Ionic/" target="_blank">Ionic</a> 和 <a href="http://blog.parryqiu.com/categories/App-%E5%BC%80%E5%8F%91/Hybrid-App/React-Native/" target="_blank">React Native</a>，都可以使用 fetch 进行完美的网络请求。</p>
<h1 id="fetch-初体验">1. fetch 初体验</h1>
<p>在 Chrome 浏览器中已经全局支持了 fetch 函数，打开调试工具，在 Console 中可以进行初体验。<br>
先不考虑跨域请求的使用方法，我们先请求同域的资源，如在我的博客页面中，打开 Console 进行如下请求。</p>
<pre><code class="hljs javascript">fetch(<span class="hljs-string">"http://blog.parryqiu.com"</span>).then(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params">response</span>)</span>{<span class="hljs-built_in">console</span>.log(response)})</code></pre>
<p>返回的数据：</p>
<p><img src="http://7xqdjc.com1.z0.glb.clouddn.com/blog_d54faa1652be14f92740685ac2b32839.png" alt="截图"></p>
<p>这样就很快速地完成了一次网络请求，我们发现返回的数据也比之前的 XMLHttpRequest 丰富、易用的多。</p>
<h1 id="关于-fetch-标准概览">2. 关于 fetch 标准概览</h1>
<p>虽然 fetch 还不是作为一个稳定的标准发布，但是在其一直迭代更新的 <a href="https://fetch.spec.whatwg.org/" target="_blank">标准描述</a> 中，我们发现已经包含了很多的好东西。<br>
fetch 支持了大部分常用的 HTTP 的请求以及和 HTTP 标准的兼容，如 HTTP Method，HTTP Headers，Request，Response。</p>
<h1 id="fetch-的使用">3. fetch 的使用</h1>
<h2 id="兼容浏览器的处理">3.1 兼容浏览器的处理</h2>
<p>可以通过下面的语句处理浏览器兼容的问题。</p>
<pre><code class="hljs swift"><span class="hljs-keyword">if</span>(<span class="hljs-keyword">self</span>.fetch) {
    <span class="hljs-comment">// 使用 fetch 框架处理</span>
} <span class="hljs-keyword">else</span> {
    <span class="hljs-comment">// 使用 XMLHttpRequest 或者其他封装框架处理</span>
}</code></pre>
<h2 id="一般构造请求的方法">3.2 一般构造请求的方法</h2>
<p>使用 fetch 的构造函数请求数据后，返回一个 <a href="https://www.promisejs.org/" target="_blank">Promise</a> 对象，处理即可。</p>
<pre><code class="hljs lua">fetch(<span class="hljs-string">"http://blog.parryqiu.com"</span>)
.<span class="hljs-keyword">then</span>(<span class="hljs-function"><span class="hljs-keyword">function</span><span class="hljs-params">(response)</span></span>{
   // <span class="hljs-keyword">do</span> something...
})</code></pre>
<h2 id="fetch-构成函数的其他选项">3.3 fetch 构成函数的其他选项</h2>
<p>我们可以将于 HTTP Headers 兼容的格式加入到请求的头中，如每次 API 的请求我们想不受缓存的影响，那么可以像下面这样请求：</p>
<pre><code class="hljs lua">fetch(<span class="hljs-string">"http://blog.parryqiu.com"</span>, {
    headers: {
        <span class="hljs-string">'Cache-Control'</span>: <span class="hljs-string">'no-cache'</span>
    }
})  
.<span class="hljs-keyword">then</span>(<span class="hljs-function"><span class="hljs-keyword">function</span><span class="hljs-params">(response)</span></span>{
   // <span class="hljs-keyword">do</span> something...
})</code></pre>
<p>具体的可选参数可以查看 <a href="https://fetch.spec.whatwg.org/#concept-request-initiator" target="_blank">这里</a>。<br>
如我们还可以这样使用：</p>
<pre><code class="hljs javascript"><span class="hljs-keyword">var</span> myHeaders = <span class="hljs-keyword">new</span> Headers();
myHeaders.append(<span class="hljs-string">"Content-Type"</span>, <span class="hljs-string">"text/plain"</span>);
myHeaders.append(<span class="hljs-string">"Content-Length"</span>, content.length.toString());
myHeaders.append(<span class="hljs-string">"X-Custom-Header"</span>, <span class="hljs-string">"ProcessThisImmediately"</span>);

<span class="hljs-keyword">var</span> myInit = {
                method: <span class="hljs-string">'GET'</span>,
                headers: myHeaders,
                mode: <span class="hljs-string">'cors'</span>,
                cache: <span class="hljs-string">'default'</span>
             };

fetch(<span class="hljs-string">"http://blog.parryqiu.com"</span>, myInit)
.then(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params">response</span>)</span>{
    <span class="hljs-comment">// do something...</span>
})</code></pre>
<h2 id="返回的数据结构">3.4 返回的数据结构</h2>
<p>在请求后的 Response 中，具体的定义在 <a href="https://fetch.spec.whatwg.org/#dom-response" target="_blank">这里</a>。<br>
常用的有：</p>
<ul>
<li>Response.status 也就是 StatusCode，如成功就是 <code>200</code>；</li>
<li>Response.statusText 是 StatusCode 的描述文本，如成功就是 <code>OK</code>；</li>
<li>Response.ok 一个 Boolean 类型的值，判断是否正常返回，也就是 StatusCode 为 <code>200-299</code>。</li>
</ul>
<p>做如下请求：</p>
<pre><code class="hljs fortran">fetch(<span class="hljs-string">"http://blog.parryqiu.com"</span>)
.<span class="hljs-keyword">then</span>(<span class="hljs-function"><span class="hljs-keyword">function</span><span class="hljs-params">(response)</span></span>{
    console.<span class="hljs-built_in">log</span>(response.<span class="hljs-keyword">status</span>);
    console.<span class="hljs-built_in">log</span>(response.statusText);
    console.<span class="hljs-built_in">log</span>(response.ok);
})</code></pre>
<p>返回的数据：</p>
<p><img src="http://7xqdjc.com1.z0.glb.clouddn.com/blog_14ba67184bbe0503caf4ad2cd09e5323.png" alt="截图"></p>
<h2 id="body-参数">3.5 Body 参数</h2>
<p>因为在 Request 和 Response 中都包含 Body 的实现，所以包含以下类型：</p>
<ul>
<li>ArrayBuffer</li>
<li>ArrayBufferView (Uint8Array and friends)</li>
<li>Blob/File</li>
<li>string</li>
<li>URLSearchParams</li>
<li>FormData</li>
</ul>
<p>在 fetch 中实现了对应的方法，并返回的都是 Promise 类型。</p>
<ul>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/API/Body/arrayBuffer" target="_blank">arrayBuffer()</a></li>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/API/Body/blob" target="_blank">blob()</a></li>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/API/Body/json" target="_blank">json()</a></li>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/API/Body/text" target="_blank">text()</a></li>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/API/Body/formData" target="_blank">formData()</a></li>
</ul>
<p>这样处理返回的数据类型就会变的特别地方便，如处理 json 格式的数据：</p>
<pre><code class="hljs javascript"><span class="hljs-keyword">var</span> myRequest = <span class="hljs-keyword">new</span> Request(<span class="hljs-string">'http://api.com/products.json'</span>);

fetch(myRequest).then(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params">response</span>) </span>{
  <span class="hljs-keyword">return</span> response.json().then(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params">json</span>) </span>{
    <span class="hljs-keyword">for</span>(i = <span class="hljs-number">0</span>; i &lt; json.products.length; i++) {
      <span class="hljs-keyword">var</span> name = json.products[i].Name;
      <span class="hljs-keyword">var</span> price = json.products[i].Price;
      <span class="hljs-comment">// do something more...</span>
    }
  });
});</code></pre>
<h1 id="浏览器兼容">4. 浏览器兼容</h1>
<p>目前项目给出的浏览器支持如下图，可以通过上面介绍的浏览器兼容处理办法解决此问题，不过相信很快就不需要考虑兼容问题了，在 Hybrid App 开发中使用基本没有问题，因为基本都是基于 Node.js 进行开发的。</p>
<p><img src="http://7xqdjc.com1.z0.glb.clouddn.com/blog_8878f051cad17b2a9c18450afff62e56.png" alt="截图"></p>
<h1 id="结语">5. 结语</h1>
<p>这里是一个格式更好的文档，比标准描述的页面更加清晰，供参考。<br>
<a href="https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API" class="uri" target="_blank">https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API</a><br>
在使用 React Native 开发 App 的时候接触到了 fetch，发现的确非常方便高效，框架的设计模式也非常清晰灵活，更多的细节可以查阅相关文档，有什么问题可以留言讨论交流。</p>
</div>
<div class="clear"></div>
