var gulp        = require('gulp');
var watch       = require('gulp-watch');
var browserSync = require('browser-sync').create();
var reload      = browserSync.reload;

// 静态服务器 + 监听 scss/html 文件
gulp.task('serve', ['css'], function() {
	browserSync.init({
		proxy: "127.0.0.1:8080"
	});
	gulp.watch("app/asset/*.css", ['css']);
	gulp.watch("app/*.html").on('change', reload);
	gulp.watch("app/js/*.js").on('change', reload);
});

gulp.task('css', function() {
	return gulp.src("app/asset/*.css")
		.pipe(reload({
			stream: true
		}));
});
gulp.task('default', ['serve']);

// scss编译后的css将注入到浏览器里实现更新
gulp.task('sass', function() {
	return gulp.src("app/scss/*.scss")
		.pipe(sass())
		.pipe(gulp.dest("app/css"))
		.pipe(reload({
			stream: true
		}));
});

browser-sync start --proxy "127.0.0.1:8080" --files "d:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web/**/*.html,d:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web/**/*.js,d:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web/**/*.css"
