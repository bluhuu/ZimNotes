// 1 类级别
// 类级别你可以理解为拓展jquery类，最明显的例子是$.ajax(...),相当于静态方法。
// 开发扩展其方法时使用$.extend方法，即jQuery.extend(object);
$.extend({
	add: function(a, b) {
		return a + b;
	},
	minus: function(a, b) {
		return a - b;
	}
});
// 页面中调用：
var i = $.add(3, 2);
var j = $.minus(3, 2);

// 2 对象级别
// 对象级别则可以理解为基于对象的拓展，如$("#table").changeColor(...);
// 这里这个changeColor呢，就是基于对象的拓展了。
// 开发扩展其方法时使用$.fn.extend方法，即jQuery.fn.extend(object);
//------------------------------------------------------------------
jQuery.fn = jQuery.prototype = {
　　　init: function( selector, context ) {//....　
　　　//......
};
//------------------------------------------------------------------
$.fn.extend({
	check: function() {
		return this.each({
			this.checked = true;
		});
	},
	uncheck: function() {
		return this.each({
			this.checked = false;
		});
	}
});
// 页面中调用：
$('input[type=checkbox]').check();
$('input[type=checkbox]').uncheck();

// 3、扩展
$.xy = {
	add: function(a, b) {
		return a + b;
	},
	minus: function(a, b) {
		return a - b;
	},
	voidMethod: function() {
		alert("void");
	}
};
var i = $.xy.add(3, 2);
var m = $.xy.minus(3, 2);
$.xy.voidMethod();

// 4、jQuery.extend()除了可以创建插件外,还可以用来扩展jQuery对象.
var a = {
	name: "blue",
	pass: 123
};
var b = {
	name: "red",
	pass: 456,
	age: 1
};
var c = jQuery.extend({}, a, b);
// c拥有a,b对象的属性,由于,b对象在a对象之后,其name属性优先在c对象里.