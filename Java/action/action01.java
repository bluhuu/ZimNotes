public void sOrderLineConfirm(HttpServletRequest req, HttpServletResponse resp, SOrderBean bean) throws IOException  {
  try {
    String ids = req.getParameter("ids");
    JSONObject jsonObject = JSONObject.fromObject(ids);
    JSONArray jsonData = JSONArray.fromObject(jsonObject.get("confirm"));
    if (jsonData.size()==0)
      throw new JsonResultException("请选择要审核的订单行!");
    for (int i=0;i<jsonData.size();i++){
      String sOrderLineId = jsonData.getString(i);
      if(sOrderLineId!=null){
        MSOrderLine line = MSOrderLine.get(Integer.valueOf(sOrderLineId));
        if(line==null){
          throw new JsonResultException("操作失败：不存在的订单行！ ");
        }else{
          BigDecimal qty = line.getQty();
          BigDecimal configQty = line.getQtyConfirmed();
          if(qty==null || qty.intValue()==0){
            throw new JsonResultException("操作失败：数量不对！  行号:" + sOrderLineId);
          }
          if(configQty!=null && configQty.intValue() > 0){
            throw new JsonResultException("订单行:"+ sOrderLineId +" 已经审核过！ ");
          }
          line.setQtyConfirmed(line.getQty());
          line.save();
        }
      }
    }
    ProcessResult<JSON> pr = new ProcessResult<JSON>(true);
    sendJSON(resp, pr.toJSON());
  } catch (Exception e) {
    // TODO: handle exception
    e.printStackTrace();
    ProcessResult<JSON> pr = new ProcessResult<JSON>(false);
    pr.setMessage(e.getMessage() != null ? e.getMessage() : e
        .toString());
    sendJSON(resp, pr.toJSON());
  }
}
