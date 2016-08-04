#mixin是什么
mixin，可以非常简单的理解，他就是把 一个 mixin 对象上的方法都混合到了另一个组件上，和 $.extend 方法做的事情类似。

不过，react对mixin做了一些特殊处理。

在mixin中写的生命周期相关的回调都会被合并，也就是他们都会执行，而不会互相覆盖掉。<br>
比如 你在mixin中可以定义 componentDidMount 来初始化组件，他不会覆盖掉使用这个mixin的组件。实际执行的时候，会先执行 mixin 的 componentDidMount ，最后执行组件的 componentDidMount 方法。

需要注意的是，因为mixin的作用是抽离公共功能，不存在渲染dom的需要，所以它没有render方法。如果你定义了render方法，那么他会和组件的render方法冲突而报错。<br>
同样，mixin不应该污染state，所以他也没有 setState 方法。mixin应该只提供接口（即方法），不应该提供任何属性。mixin内部的属性最好是通过闭包的形式作为私有变量存在。就像下面这样：
```javascript
var Timer = function() {  
 var t = 1;//私有属性  
return {//xxxx}  
}  
```
最好不要放到this上，避免污染。<br>
当然，如果你真的在this上写了一些变量，那么react也会进行mixin，因为react并不会区分你的属性到底是不是函数。
##写一个TimerMixin
我们来实现一个TimerMixin，他的提供了一个 timeTick 的方法：
```javascript
var TimerMixin = function() {
  return {
    componentDidMount: function() {
      this._interval = setInterval(this._onTick, 1000);
    },
    format: function(d) {
      return d >= 10 ? d : ("0" + d);
    },
    _onTick: function() {
      var d = new Date();
      this.timerTick(this.format(d.getHours()) + ":" + this.format(d.getMinutes()) + ":" + this.format(d.getSeconds()));
    },
    componentWillUnmount: function() {
      clearInterval(this._interval);
    }
  }
}
var Card = React.createClass({
  mixins: [
    TimerMixin()
  ],
  timerTick: function(t) {
    this.setState({
      time: t
    });
  },
  getInitialState: function() {
    return {
      time: 'loading time'
    }
  },
  render: function() {
    return ( <
      div > Hello {
        this.props.name
      }!It is {
        this.state.time
      }! < /div>  
    );
  }
});
```
前面说过，TimerMixin 的 componentDidMount 方法会先执行，然后执行 Card 的 componentDidMount 方法，如果你有疑问，可以自己通过断点来验证。
