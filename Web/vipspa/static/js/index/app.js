$(function() {
    vipspa.start({
        view: '.ui-view',// 装载视图的dom
        router: {
            '/home': {
                templateUrl: 'static/views/index/home.html',
                controller: 'static/js/index/controllers/home.js'
            },
            '/content': {
                templateUrl: 'static/views/index/content.html',
                controller: 'static/js/index/controllers/content.js'
            },
            '/component/:uuid/item/:itemid': {
                templateUrl: 'static/views/index/component.html',
                controller: 'static/js/index/controllers/component.js'
            },
            'defaults': '/home'// 不符合上述路由时，默认跳至
        },
        errorTemplateId: '#error'
    });
});