# ExtJs中继承的实现与理解--extend

## Ext中实现类的继承

```js
extend (Object subclass,Object superclass,[Object overrides] : Object)
```

第一个参数：子类  
第二个参数：父类  
第三个参数：要覆盖的属性。  
这里需要强调一下，子类继承下来的是父类中通过superclass.prototype方式定义的属性（包括用此方法定义的函数）,而不继承superclass中的定义的属性和方法，如果子类中的方法名与父类中相同则会覆盖。  
###例子:
父类
```js
BaseClass = function() {
  f1 = function() {
    alert("f1 in base");
  },
  f2 = function() {
    alert("f2 in base");
  }
};
BaseClass.prototype = {
  f3 : function() {
    alert("f3 in base");
  },
  f4 : function() {
    alert("f4 in base");
  }
};
```
子类
```js
ChildClass = function() {
}
// 继承
Ext.extend(ChildClass, BaseClass, {
  f1 : function() {
    alert("f1 in child");
  },
  f3 : function() {
    alert("f3 in child");
  }
});
```
实例化
```js
var b = new ChildClass();
b.f1();// 调用子类中的实现
//b.f2();// 会报错，因为子类中没有该方法，并且父类中定义的f2是内部变量，作用域只有在内部可见（闭包）
b.f3();// 继承并覆盖，调用子类的中的实现
b.f4();// 继承，调用父类的中的实现
```
补充：通过对 JavaScript 的原型继承的了解，可以知道，实例变量的优先级是高于 prototype 的.  
### 例子：  
父类
```js
BaseClass = function() {
  f1 = function() {
    alert("f1 in base");
  },
  f2 = function() {
    alert("f2 in base");
  }
};
BaseClass.prototype = {
  f3 : function() {
    alert("f3 in base");
  },
  f4 : function() {
    alert("f4 in base");
  }
};
```
子类
```js
ChildClass = function() {
  ChildClass.superclass.constructor.call( this );
}
// 继承
Ext.extend(ChildClass, BaseClass, {
  f1 : function() {
    alert("f1 in child");
  },
  f3 : function() {
    alert("f3 in child");
  }
});
```
实例化
```js
var b = new ChildClass();
b.f1();// 调用父类中的实现，注意不会调用子类中的实现
b.f2();// 调用父类中的实现
b.f3();// 调用子类中的实现
b.f4();// 调用父类中的实现
```
分析：在 ChildClass.superclass.constructor.call(this); 这句上， BaseClass 的 f1 成了 ChildClass 的变量，而不是 ChildClass.prototype 。由于实例变量的优先级是高于 prototype 的，所以上面的这个代码是达不到 override 的功能的。  
了解了以上知识，下面讲解一下extend的实现，先看最简单的继承，实现原理，1、将子类的原型prototype设置为父类的一个实例，也就是说把父类的实例赋值给子类的prototype（这样子类就有了父类原型的所有成员），2、重新将子类原型的构造器设置为子类自己，也就是把子类赋值给子类原型的构造器。  
以下代码把 subFn 的 prototype 设置为 superFn 的一个实例，然后设置 subFn.prototype.constructor 为 subFn。  
```js
function Extend(subFn, superFn) {
  subFn.prototype = new superFn();
  subFn.prototype.constructor = subFn;
}
//父类
function Animal() {
  this.say1 = function() {
    alert("Animal");
  }
}
//子类
function Tiger() {
  this.say2 = function() {
    alert("Tiger");
  }
}
//继承应用
Extend(Tiger, Animal);
var tiger = new Tiger();
tiger.say1();// "Animal"
tiger.say2();// "Tiger"
```
可以看到最简单的继承只做了两件事情，一是把 subFn 的 prototype 设置为 superFn 的一个实例，然后设置 subFn . prototype . constructor 为 subFn 。  
## Ext.extend 的代码
Ext.extend 函数中用到了 Ext.override ，这个函数把第二个参数中的所有对象复制到第一个对象的 prototype 中。首先贴上 Ext.override 函数的代码：  
```js
/**
  * 继承，并由传递的值决定是否覆盖原对象的属性
  * 返回的对象中也增加了 override() 函数，用于覆盖实例的成员
  * @param { Object } subclass 子类，用于继承（该类继承了父类所有属性，并最终返回该对象）
  * @param { Object } superclass 父类，被继承
  * @param { Object } overrides （该参数可选） 一个对象，将它本身携带的属性对子类进行覆盖
  * @method extend
  */
        extend : function(){
            // inline overrides
            var io = function(o){
                for(var m in o){
                    this[m] = o[m];
                }
            };
            var oc = Object.prototype.constructor;

            //匿名函数实现
            //三个参数sb、sp、overrides分别代表subClass(子类)、superClass(父类)及覆盖子类的配置参数
            return function(sb, sp, overrides){
                if(typeof sp == 'object'){//传递两个参数时superClass, overrides
                    overrides = sp;
                    sp = sb;
                    sb = overrides.constructor != oc ? overrides.constructor : function(){sp.apply(this, arguments);};
                }
                var F = function(){},//定义一空函数，用来赋给其对象时清空该对象
                    sbp,
                    spp = sp.prototype;

                F.prototype = spp;
                // 注意下面两句就是JavaScript中最简单的继承实现。
                sbp = sb.prototype = new F();//清空
                sbp.constructor=sb;
                // 添加了 superclass 属性指向 superclass 的 prototype
                sb.superclass=spp;
                if(spp.constructor == oc){
                    spp.constructor=sp;
                }
                // 为 subClass 和 subClassPrototype 添加 override 函数
                sb.override = function(o){
                    Ext.override(sb, o);
                };
                sbp.superclass = sbp.supr = (function(){
                    return spp;
                });
                sbp.override = io;
                // 覆盖掉子类 prototype 中的属性
                Ext.override(sb, overrides);
                //为子类加上类方法：extend
                sb.extend = function(o){return Ext.extend(sb, o);};
                return sb;
            };
        }(),
```
代码中进行了太多的简写，看起来不是特别方便，把代码中的简写补全，代码如下：
```js
extend : function(){
            // inline overrides
            var inlineOverride = function(o){
                for(var m in o){
                    this[m] = o[m];
                }
            };
            var oc = Object.prototype.constructor;

            return function(subFn, superFn, overrides){
                if(typeof superFn == 'object'){
                 // 如果 superFn 也是对象的话（一般来说 superFn 这里放的是父类的构造函数），那么第三个参数 overrides 参数相当于被忽略掉
                    overrides = superFn;
                    superFn = subFn;
                    //重新定义了函数 subFn
                    subFn = overrides.constructor != oc ? overrides.constructor : function(){superFn.apply(this, arguments);};
                }
                var F = function(){},
                    subFnPrototype,
                    superFnPrototype = superFn.prototype;

                F.prototype = superFnPrototype;
                subFnPrototype = subFn.prototype = new F();
                subFnPrototype.constructor=subFn;
                subFn.superclass=superFnPrototype;
                if(superFnPrototype.constructor == oc){
                    superFnPrototype.constructor=superFn;
                }
                subFn.override = function(o){
                    Ext.override(subFn, o);
                };
                subFnPrototype.superclass = subFnPrototype.supr = (function(){
                    return superFnPrototype;
                });
                subFnPrototype.override = inlineOverride;
                Ext.override(subFn, overrides);
                subFn.extend = function(o){return Ext.extend(subFn, o);};
                return subFn;
            };
        }()

```
代码中糅合了传两个参数和三个参数的实现，理解起来不容易明白，我们可以把代码拆分为两个参数和三个参数的实现，如下两个参数的 Ext.extend 代码
```js
function extend() {
    // inline overrides  
    var inlineOverride = function(o) {
        for (var m in o) {
            this[m] = o[m];
        }
    };
    return function(superFn, overrides) {
        // 定义返回的子类  
        var subFn = overrides.constructor != Object.prototype.constructor ? overrides.constructor : function() {
            superFn.apply(this, arguments);
        };
        //以下为中间变量，或叫过程变量  
        var F = function() {
            },
            subFnPrototype, superFnPrototype = superFn.prototype;

        F.prototype = superFnPrototype; //F中含有了所有 superFn.prototype 中的功能  

        // 注意下面两句就是JavaScript中最简单的继承实现。  
        subFnPrototype = subFn.prototype = new F();
        subFnPrototype.constructor = subFn;
        //改变父类实例对象中的constructor，使其指向自身的构建函数  
        if (superFnPrototype.constructor == oc) {
            superFnPrototype.constructor = superFn;
        }
        // 添加了 superclass 属性指向 superFn 的 prototype  
        subFn.superclass = superFnPrototype;

        // 为 subFn 和 subFnPrototype 添加 override 函数  
        subFn.override = function(obj) {
            Ext.override(subFn, obj);
        };
        subFnPrototype.override = inlineOverride;

        // 覆盖掉子类 prototype 中的属性  
        Ext.override(subFn, overrides);
        //为子类加上类方法：extend  
        subFn.extend = function(o) {
            Ext.extend(subFn, o);
        }
        return subFn;
    };
};
```
从注释中可以看到，做的工作很简单，只是定义一个 subFn 函数，这个函数中会调用 superFn 函数。定义了 subFn 以后，就使用上面的最简单的继承方式实现继承。然后为 subFn 和 subFn 的 prototype 添加了一个 override 函数。最后的 Ext.override(subFn, overrides); 把 overrides 中的函数写入 subFn 的 prototype 中。  
以下是传两个参数的简单例子
```js
var BaseClass = function(){};
BaseClass.prototype = {
  method1 : function(){
    alert('father class');
  }
};
//两个参数的继承
var subClass = Ext.extend(BaseClass,{
  method2 : function(){
    alert('sub class');
  }
});

var sub = new subClass();
sub.method1();
sub.method2();
```
三个参数的 Ext.extend 代码
```js
function extend() {
  // inline overrides
  var inlineOverride = function(o) {
    for (var m in o) {
      this[m] = o[m];
    }
  };
  return function(subFn, superFn, overrides) {
    // 以下为中间变量，或叫过程变量
    var F = function() {

    }, subFnPrototype, superFnPrototype = superFn.prototype;

    F.prototype = superFnPrototype;// F中含有了所有 superFn.prototype 中的功能

    // 注意下面两句就是JavaScript中最简单的继承实现。
    subFnPrototype = subFn.prototype = new F();
    subFnPrototype.constructor = subFn;

    // 添加了 superclass 属性指向 superFn 的 Prototype
    subFn.superclass = superFnPrototype;
    //改变父类实例对象中的constructor，使其指向自身的构建函数
    if(superFnPrototype.constructor == oc){
      superFnPrototype.constructor=superFn;
    }
    // 为 subFn 和 subFnPrototype 添加 override 函数
    subFn.override = function(obj) {
      Ext.override(subFn, obj);
    };
    subFnPrototype.override = inlineOverride;
    // 覆盖掉子类 prototype 中的属性
    Ext.override(subFn, overrides);
    // 为子类加上类方法：extend
    subFn.extend = function(o) {
      Ext.extend(subFn, o);
    }
    return subFn;
  };
};
```
过程与两个参数的时候相差无几，只是两个参数的时候， subFn 时重新定义的一个 function ，而三个参数的时候，这个步骤就省略了。

以下是传三个参数的例子
```js
var BaseClass = function(){};
BaseClass.prototype = {
  method1 : function(){
    alert('father class');
  }
};
//三个参数的继承
var subClass = function(){}
Ext.extend(subClass,BaseClass,{
  method2 : function(){
    alert('sub class');
  }
});
var sub = new subClass();
sub.method1();
sub.method2();
```
这样大家就对这个函数很明白了吧，也可以知道 Ext.extend 的继承只会覆写构造函数 prototype 中的对象，使用的时候需要多加注意。
