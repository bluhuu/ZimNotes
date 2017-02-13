IE6，IE7，FF的识别方式
============================================
>因为 IE系列浏览器可读 \9 ,IE6和IE7可读 * ,IE6可辨识 _ ,因此可以依照顺序写下来

--------------------------------------------

* 【区别符号】：「\9」、「*」、「_」

```css
#tip{
background:blue;/*Firefox背景变蓝色*/
background:red\9;/*IE8背景变红色*/
*background:black;/*IE7背景变黑色*/
_background:orange;/*IE6背景变橘色*/
}
```

* IE7，FF能识别!important;IE6不能识别

```css
body{
!important;background:blue;
}
```

*** 注：不管是什么方法，书写的顺序都是firefox的写在前面，IE7的写在中间，IE6的写在最后面。
