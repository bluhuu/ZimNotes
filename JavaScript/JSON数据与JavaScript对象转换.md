## 1. JSON数据示例
{  
	"employees": [
		{"firstName": "John", "lastName": "Doe"},
		{"firstName": "Anna", "lastName": "Smith"},
		{"firstName": "Peter", "lastName": "Jones"}
	]
}  

## 2. JSON数据转换为JavaScript对象
var txt = '{ "employees" : [' +  
'{ "firstName":"John" , "lastName":"Doe" },' +  
'{ "firstName":"Anna" , "lastName":"Smith" },' +  
'{ "firstName":"Peter" , "lastName":"Jones" } ]}';  
var obj = eval ("(" + txt + ")");  
console.log(obj.employees[1].firstName);  
使用eval()函数时，必须为传入的JSON数据参数添加括号'()'，否则会报语法错误。但eval()的问题在于，除了可以解析JSON数据，也可以用于执行JavaScript脚本片段，这就会带来潜在的安全问题。
JSON提供了__专门的JSON Parser__来实现只用于解析JSON数据，不会执行scripts脚本，而且速度更快。如下：
	obj = JSON.parse(txt);  
## 3. JavaScript对象转换为JSON数据
var txt = JSON.stringify(obj);  
使用JSON.strigify()函数，将Javascript对象转换为JSON文本数据。

```html
<!DOCTYPE html>  
<html>  
<body>  
<h2>Create Object from JSON String</h2>  
<p>  
First Name: <span id="fname"></span><br>   
Last Name: <span id="lname"></span><br>   
</p>   
<script>  
var txt = '{"employees":[' +  
'{"firstName":"John","lastName":"Doe" },' +  
'{"firstName":"Anna","lastName":"Smith" },' +  
'{"firstName":"Peter","lastName":"Jones" }]}';  
  
obj = JSON.parse(txt);  
  
document.getElementById("fname").innerHTML=obj.employees[2].firstName   
document.getElementById("lname").innerHTML=obj.employees[2].lastName   
  
alert("JSON Data: \n" + JSON.stringify(obj));  
</script>  
</body>  
</html>  
```
