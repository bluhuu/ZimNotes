# rest运算符
Created Thursday 23 June 2016

## rest运算符也是三个点号，不过其功能与扩展运算符恰好相反，把逗号隔开的值序列组合成一个数组
```js
//主要用于不定参数，所以ES6开始可以不再使用arguments对象
var bar = function(...args) {
  for (let el of args) {
	console.log(el);
  }
}
bar(1, 2, 3, 4);
//1
//2
//3
//4

bar = function(a, ...args) {
  console.log(a);
  console.log(args);
}
bar(1, 2, 3, 4);
//1
//[ 2, 3, 4 ]
//
//rest运算符配合解构使用：

var [a, ...rest] = [1, 2, 3, 4];
console.log(a);//1
console.log(rest);//[2, 3, 4]
```
