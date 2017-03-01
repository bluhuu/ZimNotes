gulp.task('webserver', function() {
	gulp.src('./market')
		.pipe(webserver({
			livereload: true,
			directoryListing: {
				enable:true,
				path: 'market'
			},
			port: 8000,
			// 这里是关键！
			middleware: function(req, res, next) {
				var urlObj = url.parse(req.url, true),
					method = req.method;
				switch (urlObj.pathname) {
					case '/api/orders':
						var data = {
							"status": 0,
							"errmsg": "", 
							"data": [{}]
						};
						res.setHeader('Content-Type', 'application/json');
						res.end(JSON.stringify(data));
						return;
					case '/api/goods':
						// ...
						return;
					case '/api/images':
						// ...
						return;
					default:
						;
				}
				next();
			}
		}));
});



var connect = require('gulp-connect');
var proxy = require('http-proxy-middleware');

gulp.task('serverName', function() {
    connect.server({
        root: ['path'],
        port: 8000,
        livereload: true,
        middleware: function(connect, opt) {
            return [
                proxy('/api',  {
                    target: 'http://localhost:8080',
                    changeOrigin:true
                }),
                proxy('/otherServer', {
                    target: 'http://IP:Port',
                    changeOrigin:true
                })
            ]
        }

    });
});