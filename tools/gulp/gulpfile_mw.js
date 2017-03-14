var gulp = require('gulp');
var proxy = require('http-proxy-middleware');
var watch = require('gulp-watch');
var browserSync = require('browser-sync').create();

gulp.task('default',function(){
	// 代理配置, 实现环境切换
	var proxy1 = proxy(['/elink_eai_web'], {target: 'http://192.168.20.206:8080/', changeOrigin: true});
	var proxy2 = proxy(['/elink_eai_web'], {target: 'http://192.168.20.206:8080/', changeOrigin: true});
	// 'http://192.168.20.206:8080/elink_eai_web/v1/open'
	browserSync.init({
		// notify:false, //关闭页面通知
		server: {
			baseDir: './',
			port: 3000,
			middleware: [proxy]
		}
	});
	gulp.watch("app/asset/css/*.css").on('change', browserSync.reload);
	gulp.watch("app/*.html").on('change', browserSync.reload);
	gulp.watch("app/asset/js/*.js").on('change', browserSync.reload);
});

