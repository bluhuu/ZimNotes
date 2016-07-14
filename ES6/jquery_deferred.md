<div class="asset-content entry-content" id="main-content">

                                    <!-- div class="asset-body" -->
                                        <p><a href="http://jquery.com/" target="_blank">jQuery</a>的开发速度很快，几乎每半年一个大版本，每两个月一个小版本。</p>
                                    <!-- /div -->


                                    <!-- div id="more" class="asset-more" -->
                                        <p>每个版本都会引入一些新功能。今天我想介绍的，就是从jQuery 1.5.0版本开始引入的一个新功能----<a href="http://api.jquery.com/category/deferred-object/" target="_blank">deferred对象</a>。</p>

<p>这个功能很重要，未来将成为jQuery的核心方法，它彻底改变了如何在jQuery中使用ajax。为了实现它，jQuery的全部ajax代码都被改写了。但是，它比较抽象，初学者很难掌握，网上的教程也不多。所以，我把自己的学习笔记整理出来了，希望对大家有用。</p>

<p>本文不是初级教程，针对的读者是那些已经具备jQuery使用经验的开发者。如果你想了解jQuery的基本用法，请阅读我编写的<a href="http://www.ruanyifeng.com/blog/2011/07/jquery_fundamentals.html" target="_blank">《jQuery设计思想》</a>和<a href="http://www.ruanyifeng.com/blog/2011/08/jquery_best_practices.html" target="_blank">《jQuery最佳实践》</a>。</p>

<p>======================================</p>

<p><strong>jQuery的deferred对象详解</strong></p>

<p>作者：阮一峰</p>

<p><img src="http://image.beekka.com/blog/201108/bg2011081601.jpg"></p>

<p><strong>一、什么是deferred对象？</strong></p>

<p>开发网站的过程中，我们经常遇到某些耗时很长的javascript操作。其中，既有异步的操作（比如ajax读取服务器数据），也有同步的操作（比如遍历一个大型数组），它们都不是立即能得到结果的。</p>

<p>通常的做法是，为它们指定回调函数（callback）。即事先规定，一旦它们运行结束，应该调用哪些函数。</p>

<p>但是，在回调函数方面，jQuery的功能非常弱。为了改变这一点，jQuery开发团队就设计了<a href="http://api.jquery.com/category/deferred-object/" target="_blank">deferred对象</a>。</p>

<p><strong>简单说，deferred对象就是jQuery的回调函数解决方案。</strong>在英语中，defer的意思是"延迟"，所以deferred对象的含义就是"延迟"到未来某个点再执行。</p>

<p>它解决了如何处理耗时操作的问题，对那些操作提供了更好的控制，以及统一的编程接口。它的主要功能，可以归结为四点。下面我们通过示例代码，一步步来学习。</p>

<p><strong>二、ajax操作的链式写法</strong></p>

<p>首先，回顾一下jQuery的ajax操作的传统写法：</p>

<blockquote>

<p>　　$.ajax({</p>

<p>　　　　url: "test.html",</p>

<p>　　　　success: function(){<br>
　　　　　　alert("哈哈，成功了！");<br>
　　　　},</p>

<p>　　　　error:function(){<br>
　　　　　　alert("出错啦！");<br>
　　　　}</p>

<p>　　});</p>

<p>（运行<a href="http://jsfiddle.net/ruanyf/pdQYH/" target="_blank">代码示例1</a>）</p>

</blockquote>

<p>在上面的代码中，$.ajax()接受一个对象参数，这个对象包含两个方法：success方法指定操作成功后的回调函数，error方法指定操作失败后的回调函数。</p>

<p>$.ajax()操作完成后，如果使用的是低于1.5.0版本的jQuery，返回的是XHR对象，你没法进行链式操作；如果高于1.5.0版本，返回的是deferred对象，可以进行链式操作。</p>

<p>现在，新的写法是这样的：</p>

<blockquote>

<p>　　$.ajax("test.html")</p>

<p>　　<strong>.done(function(){ alert("哈哈，成功了！"); })</strong></p>

<p>　　<strong>.fail(function(){ alert("出错啦！"); });</strong></p>

<p>（运行<a href="http://jsfiddle.net/ruanyf/dYKLJ/" target="_blank">代码示例2</a>）</p>

</blockquote>

<p>可以看到，<a href="http://api.jquery.com/deferred.done/" target="_blank">done()</a>相当于success方法，<a href="http://api.jquery.com/deferred.fail/" target="_blank">fail()</a>相当于error方法。采用链式写法以后，代码的可读性大大提高。</p>

<p><strong>三、指定同一操作的多个回调函数</strong></p>

<p>deferred对象的一大好处，就是它允许你自由添加多个回调函数。</p>

<p>还是以上面的代码为例，如果ajax操作成功后，除了原来的回调函数，我还想再运行一个回调函数，怎么办？</p>

<p>很简单，直接把它加在后面就行了。</p>

<blockquote>

<p>　　$.ajax("test.html")</p>

<p>　　.done(function(){ alert("哈哈，成功了！");} )</p>

<p>　　.fail(function(){ alert("出错啦！"); } )</p>

<p>　　<strong>.done(function(){ alert("第二个回调函数！");} );</strong></p>

<p>（运行<a href="http://jsfiddle.net/ruanyf/sQYjs/" target="_blank">代码示例3</a>）</p>

</blockquote>

<p>回调函数可以添加任意多个，它们按照添加顺序执行。</p>

<p><strong>四、为多个操作指定回调函数</strong></p>

<p>deferred对象的另一大好处，就是它允许你为多个事件指定一个回调函数，这是传统写法做不到的。</p>

<p>请看下面的代码，它用到了一个新的方法<a href="http://api.jquery.com/jQuery.when/" target="_blank">$.when()</a>：</p>

<blockquote>

<p>　　<strong>$.when($.ajax("test1.html"), $.ajax("test2.html"))</strong></p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>（运行<a href="http://jsfiddle.net/ruanyf/CdKjn/" target="_blank">代码示例4</a>）</p>

</blockquote>

<p>这段代码的意思是，先执行两个操作$.ajax("test1.html")和$.ajax("test2.html")，如果都成功了，就运行done()指定的回调函数；如果有一个失败或都失败了，就执行fail()指定的回调函数。</p>

<p><strong>五、普通操作的回调函数接口（上）</strong></p>

<p>deferred对象的最大优点，就是它把这一套回调函数接口，从ajax操作扩展到了所有操作。也就是说，任何一个操作----不管是ajax操作还是本地操作，也不管是异步操作还是同步操作----都可以使用deferred对象的各种方法，指定回调函数。</p>

<p>我们来看一个具体的例子。假定有一个很耗时的操作wait：</p>

<blockquote>

<p>　　var wait = function(){</p>

<p>　　　　var tasks = function(){</p>

<p>　　　　　　alert("执行完毕！");</p>

<p>　　　　};</p>

<p>　　　　setTimeout(tasks,5000);</p>

<p>　　};</p>

</blockquote>

<p>我们为它指定回调函数，应该怎么做呢？</p>

<p>很自然的，你会想到，可以使用$.when()：</p>

<blockquote>

<p>　　$.when(wait())</p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>（运行<a href="http://jsfiddle.net/5wzrt/" target="_blank">代码示例5</a>）</p>

</blockquote>

<p>但是，这样写的话，done()方法会立即执行，起不到回调函数的作用。原因在于$.when()的参数只能是deferred对象，所以必须对wait()进行改写：</p>

<blockquote>

<p>　　var dtd = $.Deferred(); // 新建一个deferred对象</p>

<p>　　var wait = function(dtd){</p>

<p>　　　　var tasks = function(){</p>

<p>　　　　　　alert("执行完毕！");</p>

<p>　　　　　　<strong>dtd.resolve();</strong> // 改变deferred对象的执行状态</p>

<p>　　　　};</p>

<p>　　　　setTimeout(tasks,5000);</p>

<p>　　　　<strong>return dtd;</strong></p>

<p>　　};</p>

</blockquote>

<p>现在，wait()函数返回的是deferred对象，这就可以加上链式操作了。</p>

<blockquote>

<p>　　$.when(wait(dtd))</p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>（运行<a href="http://jsfiddle.net/gfFPj/" target="_blank">代码示例6</a>）</p>

</blockquote>

<p>wait()函数运行完，就会自动运行done()方法指定的回调函数。</p>

<p><strong>六、deferred.resolve()方法和deferred.reject()方法</strong></p>

<p>如果仔细看，你会发现在上面的wait()函数中，还有一个地方我没讲解。那就是<a href="http://api.jquery.com/deferred.resolve" target="_blank">dtd.resolve()</a>的作用是什么？</p>

<p>要说清楚这个问题，就要引入一个新概念"执行状态"。jQuery规定，deferred对象有三种执行状态----未完成，已完成和已失败。如果执行状态是"已完成"（resolved）,deferred对象立刻调用done()方法指定的回调函数；如果执行状态是"已失败"，调用fail()方法指定的回调函数；如果执行状态是"未完成"，则继续等待，或者调用<a href="http://api.jquery.com/deferred.progress/" target="_blank">progress()</a>方法指定的回调函数（jQuery1.7版本添加）。</p>

<p>前面部分的ajax操作时，deferred对象会根据返回结果，自动改变自身的执行状态；但是，在wait()函数中，这个执行状态必须由程序员手动指定。dtd.resolve()的意思是，将dtd对象的执行状态从"未完成"改为"已完成"，从而触发done()方法。</p>

<p>类似的，还存在一个<a href="http://api.jquery.com/deferred.reject" target="_blank">deferred.reject()</a>方法，作用是将dtd对象的执行状态从"未完成"改为"已失败"，从而触发fail()方法。</p>

<blockquote>

<p>　　var dtd = $.Deferred(); // 新建一个Deferred对象</p>

<p>　　var wait = function(dtd){</p>

<p>　　　　var tasks = function(){</p>

<p>　　　　　　alert("执行完毕！");</p>

<p>　　　　　　<strong>dtd.reject(); // 改变Deferred对象的执行状态</strong></p>

<p>　　　　};</p>

<p>　　　　setTimeout(tasks,5000);</p>

<p>　　　　return dtd;</p>

<p>　　};</p>

<p>　　$.when(wait(dtd))</p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>（运行<a href="http://jsfiddle.net/bhDjd/" target="_blank">代码示例7</a>）</p>

</blockquote>

<p><strong>七、deferred.promise()方法</strong></p>

<p>上面这种写法，还是有问题。那就是dtd是一个全局对象，所以它的执行状态可以从外部改变。</p>

<p>请看下面的代码：</p>

<blockquote>

<p>　　var dtd = $.Deferred(); // 新建一个Deferred对象</p>

<p>　　var wait = function(dtd){</p>

<p>　　　　var tasks = function(){</p>

<p>　　　　　　alert("执行完毕！");</p>

<p>　　　　　　dtd.resolve(); // 改变Deferred对象的执行状态</p>

<p>　　　　};</p>

<p>　　　　setTimeout(tasks,5000);</p>

<p>　　　　return dtd;</p>

<p>　　};</p>

<p>　　$.when(wait(dtd))</p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>　　<strong>dtd.resolve(); </strong></p>

<p>（运行<a href="http://jsfiddle.net/nBFse/" target="_blank">代码示例8</a>）</p>

</blockquote>

<p>我在代码的尾部加了一行dtd.resolve()，这就改变了dtd对象的执行状态，因此导致done()方法立刻执行，跳出"哈哈，成功了！"的提示框，等5秒之后再跳出"执行完毕！"的提示框。</p>

<p>为了避免这种情况，jQuery提供了<a href="http://api.jquery.com/deferred.promise/" target="_blank">deferred.promise()</a>方法。它的作用是，在原来的deferred对象上返回另一个deferred对象，后者只开放与改变执行状态无关的方法（比如done()方法和fail()方法），屏蔽与改变执行状态有关的方法（比如resolve()方法和reject()方法），从而使得执行状态不能被改变。</p>

<p>请看下面的代码：</p>

<blockquote>

<p>　　var dtd = $.Deferred(); // 新建一个Deferred对象</p>

<p>　　var wait = function(dtd){</p>

<p>　　　　var tasks = function(){</p>

<p>　　　　　　alert("执行完毕！");</p>

<p>　　　　　　dtd.resolve(); // 改变Deferred对象的执行状态</p>

<p>　　　　};<br>
 <br>
　　　　setTimeout(tasks,5000);</p>

<p>　　　　<strong>return dtd.promise(); // 返回promise对象</strong></p>

<p>　　};</p>

<p>　　<strong>var d = wait(dtd); // 新建一个d对象，改为对这个对象进行操作</strong></p>

<p>　　$.when(d)</p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>　　<strong>d.resolve(); // 此时，这个语句是无效的</strong></p>

<p>（运行<a href="http://jsfiddle.net/Yur4R/" target="_blank">代码示例9</a>）</p>

</blockquote>

<p>在上面的这段代码中，wait()函数返回的是promise对象。然后，我们把回调函数绑定在这个对象上面，而不是原来的deferred对象上面。这样的好处是，无法改变这个对象的执行状态，要想改变执行状态，只能操作原来的deferred对象。</p>

<p>不过，更好的写法是<a href="http://blog.allenm.me/2012/01/jquery_deferred_promise_method/" target="_blank">allenm</a>所指出的，将dtd对象变成wait(）函数的内部对象。</p>

<blockquote>

<p>　　var wait = function(dtd){</p>

<p>　　　　<strong>var dtd = $.Deferred(); //在函数内部，新建一个Deferred对象</strong></p>

<p>　　　　var tasks = function(){</p>

<p>　　　　　　alert("执行完毕！");</p>

<p>　　　　　　dtd.resolve(); // 改变Deferred对象的执行状态</p>

<p>　　　　};<br>
 <br>
　　　　setTimeout(tasks,5000);</p>

<p>　　　　return dtd.promise(); // 返回promise对象</p>

<p>　　};</p>

<p>　　<strong>$.when(wait())</strong></p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>（运行<a href="http://jsfiddle.net/q9TvT/" target="_blank">代码示例10</a>）</p>

</blockquote>

<p><strong>八、普通操作的回调函数接口（中）</strong></p>

<p>另一种防止执行状态被外部改变的方法，是使用deferred对象的建构函数$.Deferred()。</p>

<p>这时，wait函数还是保持不变，我们直接把它传入$.Deferred()：</p>

<blockquote>

<p>　　<strong>$.Deferred(wait)</strong></p>

<p>　　.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>（运行<a href="http://jsfiddle.net/ruanyf/CucGp/" target="_blank">代码示例11</a>）</p>

</blockquote>

<p>jQuery规定，$.Deferred()可以接受一个函数名（注意，是函数名）作为参数，$.Deferred()所生成的deferred对象将作为这个函数的默认参数。</p>

<p><strong>九、普通操作的回调函数接口（下）</strong></p>

<p>除了上面两种方法以外，我们还可以直接在wait对象上部署deferred接口。</p>

<blockquote>

<p>　　var dtd = $.Deferred(); // 生成Deferred对象</p>

<p>　　var wait = function(dtd){</p>

<p>　　　　var tasks = function(){</p>

<p>　　　　　　alert("执行完毕！");</p>

<p>　　　　　　dtd.resolve(); // 改变Deferred对象的执行状态</p>

<p>　　　　};</p>

<p>　　　　setTimeout(tasks,5000);</p>

<p>　　};</p>

<p>　　<strong>dtd.promise(wait);</strong></p>

<p>　　wait.done(function(){ alert("哈哈，成功了！"); })</p>

<p>　　.fail(function(){ alert("出错啦！"); });</p>

<p>　　wait(dtd);</p>

<p>（运行<a href="http://jsfiddle.net/ruanyf/PF7Xf/" target="_blank">代码示例12</a>）</p>

</blockquote>

<p>这里的关键是dtd.promise(wait)这一行，它的作用就是在wait对象上部署Deferred接口。正是因为有了这一行，后面才能直接在wait上面调用done()和fail()。</p>

<p><strong>十、小结：deferred对象的方法</strong></p>

<p>前面已经讲到了deferred对象的多种方法，下面做一个总结：</p>

<p>　　（1） <a href="http://api.jquery.com/category/deferred-object/" target="_blank">$.Deferred()</a> 生成一个deferred对象。</p>

<p>　　（2） <a href="http://api.jquery.com/deferred.done/" target="_blank">deferred.done()</a> 指定操作成功时的回调函数</p>

<p>　　（3） <a href="http://api.jquery.com/deferred.fail/" target="_blank">deferred.fail()</a> 指定操作失败时的回调函数</p>

<p>　　（4） <a href="http://api.jquery.com/deferred.promise/" target="_blank">deferred.promise()</a> 没有参数时，返回一个新的deferred对象，该对象的运行状态无法被改变；接受参数时，作用为在参数对象上部署deferred接口。</p>

<p>　　（5） <a href="http://api.jquery.com/deferred.resolve/" target="_blank">deferred.resolve()</a> 手动改变deferred对象的运行状态为"已完成"，从而立即触发done()方法。</p>

<p>　　（6）<a href="http://api.jquery.com/deferred.reject/" target="_blank">deferred.reject()</a> 这个方法与deferred.resolve()正好相反，调用后将deferred对象的运行状态变为"已失败"，从而立即触发fail()方法。</p>

<p>　　（7） <a href="http://api.jquery.com/jQuery.when/" target="_blank">$.when()</a> 为多个操作指定回调函数。</p>

<p>除了这些方法以外，deferred对象还有二个重要方法，上面的教程中没有涉及到。</p>

<p>　　（8）<a href="http://api.jquery.com/deferred.then/" target="_blank">deferred.then()</a></p>

<p>有时为了省事，可以把done()和fail()合在一起写，这就是then()方法。</p>

<blockquote>

<p>　　$.when($.ajax( "/main.php" ))</p>

<p>　　<strong>.then(successFunc, failureFunc );</strong></p>

</blockquote>

<p>如果then()有两个参数，那么第一个参数是done()方法的回调函数，第二个参数是fail()方法的回调方法。如果then()只有一个参数，那么等同于done()。</p>

<p>　　（9）<a href="http://api.jquery.com/deferred.always/" target="_blank">deferred.always()</a></p>

<p>这个方法也是用来指定回调函数的，它的作用是，不管调用的是deferred.resolve()还是deferred.reject()，最后总是执行。</p>

<blockquote>

<p>　　$.ajax( "test.html" )</p>

<p>　　.always( function() { alert("已执行！");} );</p>

</blockquote>

<p>（致谢：本文第一稿发表后，<a href="http://blog.allenm.me/" target="_blank">allenm</a>来信指出原文对promise()的理解是错的。现在的第二稿是根据<a href="http://blog.allenm.me/2012/01/jquery_deferred_promise_method/" target="_blank">他的文章</a>修改的，在此我表示衷心感谢。）</p>

<p>（完）<br>
</p>
                                    <!-- /div -->

                                </div>
