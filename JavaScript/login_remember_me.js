var Login = {
write:function (name,pd){
	$.cookie("usn",name,{expires:30,path:"/"});
	$.cookie("usp",pd,{expires:30,path:"/"});
},
//读取cookied历史记录
read:function (){
	var n=$.cookie("usn");
	var p=$.cookie("usp");
	if(n&&n.length >0){
    	$('#username').val(n);
		$('#remember_me').prop('checked',true);
	}
	if(n&&n.length >0&&p&&p.length >0){
    	$('#password').val(p);
	}
},
clear : function ()
{
	$.cookie("usn",null,{path:"/"});
	$.cookie("usp",null,{path:"/"});
}
};
