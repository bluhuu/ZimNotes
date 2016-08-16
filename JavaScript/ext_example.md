##Ext.extend
这里需要强调一下，子类继承下来的是父类中通过superclass.prototype方式定义的属性（包括用此方法定义的函数）。
```js
  function S() {}
  S.prototype.s = "s";
  S.prototype.s1 = "s1";

  function C() {
      this.c = "c";
      this.c1 = "c1";
  }
  Ext.extend(C, S, {
      s1: "by c overload"
  });
  var c = new C();
  alert(c.s); //s
  alert(c.s1); //by c overload
```

子类继承下来的是父类中通过superclass.prototype方式定义的属性
```js
  function S() {
      this.s = "s";
      this.s1 = "s1";
  }

  function C() {
      this.c = "c";
      this.c1 = "c1";
  }
  Ext.extend(C, S, {
      s1: "by c overload"
  });
  var c = new C();
  alert(c.s); //undefind
  alert(c.s1); //by c overload
```
两个参数
```js
  function S() {}
  S.prototype.s = "s";
  S.prototype.s1 = "s1";
  C = Ext.extend(S, {
      s1: "by c overload"
  });
  var c = new C();
  alert(c.s); //s
  alert(c.s1); //by c overload
```

```js
function Base(config) {
  this.name=config.name;
  this.age=config.age;
  this.sex=config.sex;
}

function base(config) {
 this.identity=config.identity;
 this.msg=config.msg;
 this.phone=config.phone;

 base.superclass.constructor.call(this,config);
}

Ext.extend(base,Base,{
   showMsg:function(){
     window.alert(this.name+' '+this.age+' '+this.sex+' '+this.identity+' '+this.msg+' '+this.phone);
   }
});

 var mybase=new base({
       name:’’,
       age:’’,
       sex:’’,
       identity:’’,
       msg:’’,
       phone:’’
 });
 mybase.showMsg();
```
