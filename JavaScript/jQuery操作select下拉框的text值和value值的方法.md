1、jquery获取当前选中select的text值

var checkText=$("#slc1").find("option:selected").text();

2、jquery获取当前选中select的value值

var checkValue=$("#slc1").val();

3、jquery获取当前选中select的索引值

var index=$("#slc1 ").get(0).selectedIndex;

4、jquery设置索引值为1的项为当前选中项

$("#slc1 ").get(0).selectedIndex=1;

5、jquery设置value值2的项为当前选中项

$("#slc1 ").val(2);

6、jquery设置text值为"青藤园"的项为当前选中项

$("#slc1 option[text='青园w']").attr("selected",true);

7、为指定select下拉框追加一个option（追加到在末尾）

$("#slc2").append(""+i+"");

8、为制定select下拉框插入一个option（插入到第一个位置）

$("#slc2").prepend("请选择");

9、jquery删除select下拉框的最后一个option

$("#slc2 option:last").remove();
