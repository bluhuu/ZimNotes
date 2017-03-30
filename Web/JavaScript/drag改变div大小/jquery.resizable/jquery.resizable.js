/*
*resizable 0.1
*Copyright (c) 2015 小坏 http://tnnyang.cnblogs.com
*Dependenc jquery-1.7.1.js
*/
;(function(a){
	a.fn.resizable = function(options){
		var defaults = {   //默认参数
			minW : 150,
			minH : 150,
			maxW : 500,
			maxH : 500,
			}
		var opts = a.extend(defaults, options);
		
		this.each(function(){
			var obj = a(this);	
			obj.mousedown(function(e){	
				var e = e || event;    //区分IE和其他浏览器事件对象
				var x = e.pageX - obj.position().left;	//获取鼠标距离匹配元素的父元素左侧的距离						
				var y = e.pageY - obj.position().top;     //获取鼠标距离匹配元素的父元素顶端的距离
				
				$(document).mousemove(function(e){
					var e = e || event;
					var _x = e.pageX - x;        //动态获取匹配元素距离其父元素左侧的宽度
					var _y = e.pageY - y;
					_x = _x < opts.minW ? opts.minW : _x;      //保证匹配元素的最小宽度为150px
					_x = _x > opts.maxW ? opts.maxW : _x;    //保证匹配元素的最大宽度为500px
					_y = _y < opts.minH ? opts.minH : _y;
					_y = _y > opts.maxH ? opts.maxH : _y;  	
					obj.parent().css({width:_x,height:_y});
				}).mouseup(function(){
					$(this).unbind("mousemove");  //当鼠标抬起  删除移动事件   匹配元素宽高变化停止
					});
				});
			
			})
		}
	})(jQuery);