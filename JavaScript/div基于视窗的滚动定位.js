//函数用法
function getTopOfWindow(id) {
  var box = document.getElementById(id).getBoundingClientRect();
  return box.top;
}

function setFixedInWindow(id, top) {
  if(top<0){
    document.getElementById(id).style.position = "fixed";
    document.getElementById(id).style.top = "0";
  }else{
    document.getElementById(id).style.position = "static";
  }
}
window.onscroll = function() {
  var top = getTopOfWindow("parentId");//父窗口
  setRelativeForWindow("id", top);//当前窗口
};

//对象用法
function fixedOnScroll(parentId,childId) {
  var that    = this;
  this.parentId  = parentId;
  this.childId    = childId;

  window.onscroll = function() {
    var top = that.getTopOfWindow(parentId);//父窗口
    that.setFixedInWindow(childId, top);//当前窗口
  };
}
fixedOnScroll.prototype.getTopOfWindow = function(id) {
  var box = document.getElementById(id).getBoundingClientRect();
  return box.top;
}
fixedOnScroll.prototype.setFixedInWindow = function(id, top) {
  if(top<0){
    document.getElementById(id).style.position = "fixed";
    document.getElementById(id).style.top = "0";
  }else{
    document.getElementById(id).style.position = "static";
  }
}

//例
new fixedOnScroll('sidebar','tools')