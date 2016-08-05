
doConfirm: function(){
this.linegrid.stopEditing();
var records = this.linestore.getModifiedRecords();
if ((this.removed && this.removed.length>0)||(records&&records.length>0)){
  Ext.MessageBox.alert('警告','请先登记后再确认!');
  return;
}

var record = this.grid.getSelectionModel().getSelected();
if (!record){
  Ext.MessageBox.alert('错误','请选择订单行！');
  return;
}
var recordline = this.linegrid.getSelectionModel().getSelected();
if (!recordline){
  Ext.MessageBox.alert('错误','请选择配送行！');
  return;
}
// var json = this.linegrid.getStore().reader.jsonData;

var lines = this.linegrid.getSelectionModel().getSelections();
var linesjson = new Array();
for(var i=0;i<lines.length;i++){
  linesjson.push(lines[i].data);
}

// var qtyDelivered = 0;
// for(var i=0;i<linesjson.length;i++){
// 	var qty = linesjson[i].Qty;
// 	qtyDelivered = qtyDelivered+qty;
// }
var SOrderLineID = record.data["S_OrderLine_ID"];
var orderLineID = record.data["EAI_OrderLine_ID"];
var send = {confirm:linesjson};
Ext.Ajax.request({
  url : delivery_input_action+'/save.do',
  method : 'POST',
  params : {
    SOrderLineID:SOrderLineID,
    // qtyDelivered:qtyDelivered,
    orderLineID : orderLineID,
    lineData : Ext.util.JSON.encode(send)
  },
  scope: this,
  waitMsg: '正在处理...',
  success : function(result, request) {
    var jsonData = Ext.util.JSON.decode(result.responseText);
    if (jsonData.success){
      var records = this.linestore.getModifiedRecords();
      this.linestore.commitChanges();
      // 修改store 的内容
      record.set('Qtydelivered',jsonData.data.ProcessedQty);
      this.store.commitChanges();
      // ---
      this.removed=[];
      this.linestore.load({params:{start:0,limit:this.linestore.pageSize}});
      Ext.MessageBox.alert('确认成功',jsonData.msg,function(){
        //this.store.remove(record);//移除处理过的订单行
      }.createDelegate(this));
    }else {
      Ext.MessageBox.alert('保存失败',jsonData.msg);
    }
  },
  failure : function(result, request) {
    App.handleError('操作失败','response',result);
  }
});
