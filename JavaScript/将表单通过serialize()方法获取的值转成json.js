$.ajaxSetup({
    contentType: "application/x-www-form-urlencoded; charset=utf-8"
});
var DataDeal = {
    //将从form中通过$('#form').serialize()获取的值转成json  
    formToJson: function (data) {
        data = data.replace(/&/g, "\",\"");
        data = data.replace(/=/g, "\":\"");
        data = "{\"" + data + "\"}";
        return data;
    },
};


var data = $('#addf').serialize(); //获取值  
data     = decodeURIComponent(data, true); //防止中文乱码  
var json = DataDeal.formToJson(data); //转化为json