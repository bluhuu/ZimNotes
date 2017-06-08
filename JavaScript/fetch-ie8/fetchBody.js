let formData = new FormData();
formData.append('SiteBpartnerID', '1021862');

promise = fetch('http://192.168.20.206:8080/elink_eai_web/siteBpartnerAction/queryDetail.do', {
    method: 'post',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
    },
    body: "SiteBpartnerID=1021862&bb=22&cc=33",
    credentials: "include"
}).then((value) => {
    console.log(value);
    console.log(value.headers);
    return value.json();
}).then((value) => {
    console.log(value);
}).catch((e) => {
    console.log(e);
});

promise = fetch('http://192.168.20.206:8080/elink_eai_web/siteBpartnerAction/queryDetail.do', {
    method: 'post',
    body: formData,
    credentials: "include"
}).then((value) => {
    return value.json()
}).then((value) => {
    console.log(value);
}).catch((e) => {
    console.log(e);
})

promise = fetch('http://192.168.20.206:8080/elink_eai_web/siteBpartnerAction/queryDetail.do', {
    method: 'post',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        SiteBpartnerID: 1021862
    }),
    credentials: "include"
}).then((value) => {
    return value.json()
}).then((value) => {
    console.log(value);
}).catch((e) => {
    console.log(e);
})

promise = fetch('http://192.168.20.206:8080/elink_eai_web/siteBpartnerAction/queryDetail.do?SiteBpartnerID=1021862&bb=22&cc=33', {
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
    },
    credentials: "include"
}).then((value) => {
    return value.json()
}).then((value) => {
    console.log(value);
}).catch((e) => {
    console.log(e);
})

promise = fetch('http://192.168.20.206:8080/elink_eai_web/siteBpartnerAction/queryDetail.do?SiteBpartnerID=1021862&bb=22&cc=33', {
    credentials: "include"
}).then((value) => {
    return value.json()
}).then((value) => {
    console.log(value);
}).catch((e) => {
    console.log(e);
})
