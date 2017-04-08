# 去除inline-block元素间间距的N种方法
## 方法之移除空格
```html
<div class="space">
    <a href="##">
    惆怅</a><a href="##">
    淡定</a><a href="##">
    热血</a>
</div>
```
```html
<div class="space">
    <a href="##">惆怅</a
    ><a href="##">淡定</a
    ><a href="##">热血</a>
</div>
```
```html
<div class="space">
    <a href="##">惆怅</a><!--
    --><a href="##">淡定</a><!--
    --><a href="##">热血</a>
</div>
```
## 使用margin负值
```css
.space a {
    display: inline-block;
    margin-right: -3px;
}
```
## 让闭合标签吃胶囊
```html
<div class="space">
    <a href="##">惆怅
    <a href="##">淡定
    <a href="##">热血</a>
</div>
```
## 使用font-size:0
```css
.space {
    font-size: 0;
    -webkit-text-size-adjust:none;
}
.space a {
    font-size: 12px;
}
```
## 使用letter-spacing
```css
.space {
    letter-spacing: -3px;
}
.space a {
    letter-spacing: 0;
}
```
## 使用word-spacing
```css
.space {
    display: inline-table;
    word-spacing: -6px;
}
.space a {
    word-spacing: 0;
}
```
## 其他成品方法
```css
.yui3-g {
    letter-spacing: -0.31em; /* webkit */
    *letter-spacing: normal; /* IE < 8 重置 */
    word-spacing: -0.43em; /* IE < 8 && gecko */
}
.yui3-u {
    display: inline-block; zoom: 1; *display: inline;
    letter-spacing: normal;
    word-spacing: normal;
    vertical-align: top;
}
```
```css
li {
    display:inline-block;
    background: orange;
    padding:10px;
    word-spacing:0;
    }
ul {
    width:100%;
    display:table;  /* 调教webkit*/
    word-spacing:-1em;
}
.nav li { *display:inline;}
```
## 杂交品种
```html
<div style="letter-spacing:-3px; font-size:0;">
    <img src="http://image.zhangxinxu.com/image/study/s/s128/mm1.jpg" style="border-right:4px solid #066;" />
    <img src="http://image.zhangxinxu.com/image/study/s/s128/mm2.jpg" style="border-left:4px solid #F36;" />
</div>
```
```css
.dib { display: inline-block; *display:inline; *zoom:1; }
.dib-wrap {
    font-size:0;
    letter-spacing:-5px;/* webkit */
    *letter-spacing:normal;
    word-spacing:-1px;/* IE6、7 */
}
.dib-wrap .dib{
    font-size: 12px;
    letter-spacing: normal;
    word-spacing: normal;
    vertical-align: top;
}
```



