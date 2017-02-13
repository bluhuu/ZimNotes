- first-child 属性，不过可以用其他办法替代。

  ```css
  #sidebar li:first-child{
  border-top-style:none;
  }
  #sidebar li{
  border-top-width:1px;
  border-top-style:solid;
  border-color:#DAD3D0;
  *border-top-style:expression(this.previousSibling==null?"none":"solid");
  }
  ```

  > 只有IE6和IE7能识别此行代码，第一个值'none'就是first-child的值，第二个值'solid'则是其他元素的值。

- last-child原理相同，代码如下

  ```css
  #sidebar li:last-child{
  border-bottom-style:none;
  }
  #sidebar li{
  border-bottom-width:1px;
  border-bottom-style:solid;
  border-color:#DAD3D0;
  *border-bottom-style:expression(this.nextSibling==null?"none":"solid");
  }
  ```
