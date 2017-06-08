import __config from './config'
class ServiceBase {
    constructor() {
        Object.assign(this, { $$basePath: __config.basePath })
        this.__init()
    }
    __init() {
        this.__initDefaults()
        this.__initMethods()
    }
    __initDefaults() {
        this.suffix = 'Request'
        this.instanceSource = { method: [ 'OPTIONS', 'GET', 'HEAD', 'POST', 'PUT', 'DELETE', 'PATCH', 'CONNECT', ] }
    }
    __initMethods() {
        for(let key in this.instanceSource) {
            this.instanceSource[key].forEach((method, index) => {
                this[method.toLowerCase() + this.suffix] = (...args) => this.__defaultRequest(method, ...args)
            })
        }
    }
    __defaultRequest(method = '', url = '', params = {}, header = {}, dataType = 'json') {
        const $$header = Object.assign({}, this.setHeaders(), header)
        const $$url = this.setUrl(url)
        const $$config = { url: $$url, data: params, header: $$header, method: method, dataType: dataType, }
        let requestInterceptors = []
        let responseInterceptors = []
        let reversedInterceptors = this.setInterceptors()
        reversedInterceptors.forEach((n, i) => {
            if (n.request || n.requestError) {
                requestInterceptors.push(n.request, n.requestError)
            }
            if (n.response || n.responseError) {
                responseInterceptors.unshift(n.response, n.responseError)
            }
        })
        const chainInterceptors = (promise, interceptors) => {
            for (let i = 0, ii = interceptors.length; i < ii;) {
                let thenFn = interceptors[i++]
                let rejectFn = interceptors[i++]
                promise = promise.then(thenFn, rejectFn)
            }
            return promise
        }
        let promise = this.__resolve($$config)
        promise = chainInterceptors(promise, requestInterceptors)
        promise = promise.then(this.__http)
        promise = chainInterceptors(promise, responseInterceptors)
        promise = promise.then(res => res.data, err => err)
        return promise
    }
    __http(obj) {
        return fetch(...obj).then((response) => {
                if (response.status >= 200 && response.status < 300) {
                    return response
                }
                throw new Error(response.statusText)
            }).then((response) => {
                return response.json()
            })
    }
    __resolve(res) { return new Promise((resolve, reject) => { resolve(res) }) }
    setUrl(url) { return `${this.$$basePath}${this.$$prefix}${url}` }
    setHeaders() { return { 'Cookie': 'JSESSIONID=' + wx.getStorageSync('token') + ';', } }
    setInterceptors() {
        return [{
            request: (request) => {
                request.header = request.header || {}
                request.requestTimestamp = new Date().getTime()
                if (request.url.indexOf('/elink_scm_purchase') !== -1 && wx.getStorageSync('token')) {
                    request.header.Cookie = 'JSESSIONID=' + wx.getStorageSync('token') + ";"
                }
                // wx.showToast({ title: '加载中', icon: 'loading', duration: 10000, mask: !0, })
                return request
            },
            requestError: (requestError) => {
                // wx.hideToast()
                return requestError
            },
            response: (response) => {
                response.responseTimestamp = new Date().getTime()
                if(response.data.msg === "会话超时或未登录！") {
                    wx.removeStorageSync('token')
                    wx.redirectTo({ url: '/pages/login/index' })
                }
                // wx.hideToast()
                return response
            },
            responseError: (responseError) => {
                // wx.hideToast()
                return responseError
            },
        }]
    }
}
export default ServiceBase
