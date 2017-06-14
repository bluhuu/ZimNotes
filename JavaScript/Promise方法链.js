function status(response){
    if(response.status>=200 && response.status<300){
        return Promise.resolve(response);
    }
    else{
        return Promise.reject(new Error(response.statusText));
    }
}
function json(response){
    return response.json();
}
fetch("/students.json")
.then(status)
.then(json)
.then(function(data){
    console.log("请求成功，JSON解析后的响应数据为:",data);
})
.catch(function(err){
    console.log("Fetch错误:"+err);
});