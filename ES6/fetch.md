# fetch
## 基本的fetch用法
fetch方法是全局对象window里提供的，它的第一个参数就是URL地址：
```javascript
// url (required), options (optional)
fetch('/some/url', {
	method: 'get'
}).then(function(response) {

}).catch(function(err) {
	// Error :(
});
```
它很像我们之前介绍的电池状态信息API，这个fetch API使用promises处理结果results/callbacks:

```javascript
// Simple response handling
fetch('/some/url').then(function(response) {

}).catch(function(err) {
	// Error :(
});;

// Chaining for more "advanced" handling
fetch('/some/url').then(function(response) {
	return //...
}).then(function(returnedValue) {
	// ...
}).catch(function(err) {
	// Error :(
});;
```
如果你以前没有用过then类似的方法，那就学着使用它吧——很快到处都会出现这种方法。

## 处理JSON
假如说，你需求发起一个JSON请求 — 返回的数据对象里有一个json方法，能将原始数据转化成JavaScript对象：
```javascript
fetch('http://www.webhek.com/demo/arsenal.json').then(function(response) {
	// Convert to JSON
	return response.json();
}).then(function(j) {
	// Yay, `j` is a JavaScript object
	console.log(j);
});
```
显然，它就是一个简单的JSON.parse(jsonString)调用，但json方法做为简写方式还是很方便的。

## 处理基本的Text/HTML响应
JSON并不是我们在任何时候都需要的数据格式，下面介绍一下如何处理HTML或文本格式的响应：
```javascript
fetch('/next/page')
  .then(function(response) {
    return response.text();
  }).then(function(text) {
  	// <!DOCTYPE ....
  	console.log(text);
  });
```
非常相似，你可以在Promise的then方法提供的response对象上使用text()。

## 头信息和元信息(Metadata)
response对象里还包含了丰富的HTTP头信息和metadata信息，你可以直接用get方法获取它们：
```javascript
fetch('http://www.webhek.com/demo/arsenal.json').then(function(response) {
	// Basic response properties, available at any time
	console.log(response.status)
	console.log(response.statusText)

	// Grabbing response headers via `get`
	console.log(response.headers.get('Content-Type'))
	console.log(response.headers.get('Date'))
})
```
你还可以在调用请求过程中set这些头信息：
```javascript
// url (required), options (optional)
fetch('/some/url', {
	headers: {
		'Accept': 'application/json',
    		'Content-Type': 'application/json'
	}
});
```
## 提交表单信息
Ajax另外一个常用的地方是发送表单数据，下面的这个例子就是如何用fetch发送表单数据：
```javascript
fetch('/submit', {
	method: 'post',
	body: new FormData(document.getElementById('comment-form'))
});
```
如果你发送的数据是JSON格式：
```javascript
fetch('/submit-json', {
	method: 'post',
	body: JSON.stringify({
		email: document.getElementById('email')
		answer: document.getElementById('answer')
	})
});
```
非常容易，而且看起来也非常顺眼！

## 其它要说明的

fetch是一个更好用的API，但它目前还没有提供取消请求的方法，所以，程序员用起来也需要考量一下。

这个新fetch API相比起XMLHttpRequest更简单，更易读，是很好的Ajax替代方法；fetch有很明显的优势，相信很快会流行起来！

## Fetch
我们的 fetch 请求的代码基本上是这样的：
```javascript
fetch('./api/some.json')  
  .then(  
    function(response) {  
      if (response.status !== 200) {  
        console.log('Looks like there was a problem. Status Code: ' +  
          response.status);  
        return;  
      }

      // Examine the text in the response  
      response.json().then(function(data) {  
        console.log(data);  
      });  
    }  
  )  
  .catch(function(err) {  
    console.log('Fetch Error :-S', err);  
  });
```
我们首先检查请求响应的状态是否是 200，然后才按照 JSON 对象分析响应数据。

fetch()请求获取的内容是一个 Stream 对象。也就是说，当我们调用 json() 方法时，返回的仍是一个 Promise 对象，这是因为对 stream 的读取也是异步的。

## 返回数据对象的元数据(Metadata)

在上面的例子中，我看到了服务器响应对象Response的基本状态，以及如何转换成JSON。返回的相应对象Response里还有很多的元数据信息，下面是一些：
```javascript
fetch('users.json').then(function(response) {  
    console.log(response.headers.get('Content-Type'));  
    console.log(response.headers.get('Date'));

    console.log(response.status);  
    console.log(response.statusText);  
    console.log(response.type);  
    console.log(response.url);  
});
```
## 响应的对象Response类型

当我们执行一个fetch请求时，响应的数据的类型response.type可以是“basic”, “cors” 或 “opaque”。这些类型用来说明应该如何对待这些数据和数据的来源。

当请求发起自同一个域时，响应的类型将会是“basic”，这时，对响应内容的使用将没有任何限制。

如果请求来自另外某个域，而且响应的具有CORs头信息，那么，响应的类型将是“cors”。 “cors” 和 “basic” 类型的响应基本是一样的，区别在于，“cors”类型的响应限制你只能看到的头信息包括`Cache-Control`, `Content-Language`, `Content-Type`, `Expires`, `Last-Modified`, 和 `Pragma`。

“opaque”类型的响应说明请求来自另外一个域，并且不具有 CORS 头信息。一个opaque类型的响应将无法被读取，而且不能读取到请求的状态，无法看到请求的成功与否。当前的 fetch() 实现无法执行这样的请求。原因请参考这篇文章。

你可以给fetch请求指定一个模式，要求它只执行规定模式的请求。这个模式可以分为：
* “same-origin” 只有来自同域的请求才能成功，其它的均将被拒绝。
* “cors” 允许不同域的请求，但要求有正确的 CORs 头信息。
* “cors-with-forced-preflight” 在执行真正的调用前先执行preflight check。
* “no-cors” 目前这种模式是无法执行的。

定义模式的方法是，使用一个参数对象当做fetch方法的第二个参数：
```javascript
fetch('http://some-site.com/cors-enabled/some.json', {mode: 'cors'})  
  .then(function(response) {  
    return response.text();  
  })  
  .then(function(text) {  
    console.log('Request successful', text);  
  })  
  .catch(function(error) {  
    log('Request failed', error)  
  });
```
## 串联 Promises

Promises最大的一个特征是，你可以串联各种操作。对于fetch来说，我们可以在各个fetch操作里共享一些逻辑操作。

在使用JSON API时，我们需要检查每次请求响应的状态，然后解析成JSON对象。使用promise，我们可以简单的将分析状态和解析JSON的代码放到一个单独函数里，然后当做promise返回，这样就是代码更条理了。
```javascript
function status(response) {  
  if (response.status >= 200 && response.status < 300) {  
    return Promise.resolve(response)  
  } else {  
    return Promise.reject(new Error(response.statusText))  
  }  
}

function json(response) {  
  return response.json()  
}

fetch('users.json')  
  .then(status)  
  .then(json)  
  .then(function(data) {  
    console.log('Request succeeded with JSON response', data);  
  }).catch(function(error) {  
    console.log('Request failed', error);  
  });
```
我们用 status 函数来检查 response.status 并返回 Promise.resolve() 或 Promise.reject() 的结果，这个结果也是一个 Promise。我们的fetch() 调用链条中，首先如果fetch()执行结果是 resolve，那么，接着会调用 json() 方法，这个方法返回的也是一个 Promise，这样我们就得到一个分析后的JSON对象。如果分析失败，将会执行reject函数和catch语句。

你会发现，在fetch请求中，我们可以共享一些业务逻辑，使得代码易于维护，可读性、可测试性更高。
## 用fetch执行表单数据提交

在WEB应用中，提交表单是非常常见的操作，用fetch来提交表单数据也是非常简洁。

fetch里提供了 method 和 body 参数选项。
```javascript
fetch(url, {  
    method: 'post',  
    headers: {  
      "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"  
    },  
    body: 'foo=bar&lorem=ipsum'  
  })
  .then(json)  
  .then(function (data) {  
    console.log('Request succeeded with JSON response', data);  
  })  
  .catch(function (error) {  
    console.log('Request failed', error);  
  });
```
## 在Fetch请求里发送用户身份凭证信息

如果你想在fetch请求里附带cookies之类的凭证信息，可以将 credentials 参数设置成 “include” 值。
```javascript
fetch(url, {  
  credentials: 'include'  
})
```
显而易见，fetch API相比起传统的 XMLHttpRequest (XHR) 要简单的多，相比起jQuery里提供ajax API也丝毫不逊色。


```javascript
promotionClass(){
	fetch('/elink_scm_web/sClassAction/query.do',{
				method: 'POST',
				headers: { "Content-type": "application/x-www-form-urlencoded; charset=UTF-8" },
				credentials: 'include',
				body: 'id=0&showChecked=true&node=0'
	}).then(function(response) {
		return response.json();//response.text()
	}).then(function(data) {
		console.log(data);
	}).catch(function(err) {
		console.log("sClassAction fetch 请求失败!");
	});
},
```
