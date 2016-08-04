commitOrder:function(){
  // 检查是否选择了grid订单
  var records = this.gridLine.getSelectionModel().getSelections();
  console.log(records);
  if (!records||records.length==0){
    App.showError("请选择一个订单行！");
    return;
  }
  // 获取选择行信息
  var ids = [];
  for (i=0;i<records.length;i++){
    ids.push(records[i].data['S_OrderLine_ID']);
  }
  var record = this.grid.getSelectionModel().getSelected();
  console.log(record);
  if (!record){
    App.showError("请选择一个订单！");
    return;
  }
  Ext.Msg.confirm('确认', '你确认要通过审核操作吗？', function (btn) {
    if (btn == 'yes') {
      var send = {
        confirm : ids
      };
      Ext.Ajax.request({
        url : lineAction+'/sOrderLineConfirm.do',
        method : 'POST',
        waitMsg: '正在处理...',
        scope: this,
        success : function(result, request) {
          var jsonData = Ext.util.JSON.decode(result.responseText);
          if (jsonData.success){
            records = [];
            Ext.MessageBox.alert('提示', '操作成功');
            this.storeLine.reload();
          }else {
            Ext.MessageBox.alert('操作失败',jsonData.msg);
          }
        },
        failure : function (result, request) {
          App.handleError('操作失败', 'response', result);
        },
        params : {
          ids : Ext.util.JSON.encode(send),
        }
      });
    }
  }, this);
}
