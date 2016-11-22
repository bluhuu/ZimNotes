var gulp = require('gulp'); 
var changed = require('gulp-changed');
var watch = require('gulp-watch');  

gulp.task('default',function(){
    var src  = 'D:/Workspace/elink_csp_web_stable/web/**/*',
    dist = 'D:/apache/apache-tomcat-7.0.72/webapps/elink_csp_web';
    gulp.src(src).pipe(changed(dist)).pipe(gulp.dest(dist));
    return gulp.watch(src, function(event) {
         //可加入压缩等其他任务
         gulp.src(src).pipe(changed(dist)).pipe(gulp.dest(dist));
    });
});

// var refresh = require('gulp-livereload');  
// var lr = require('tiny-lr');
// var server = lr();

// gulp.task('refreshChorm', function () {
//     var server = refresh();
//     //自动刷新浏览器
//     gulp.watch('E:/main/FrontEnd/src/**/*.*', function (file) {
//         server.changed(file.path);
//     });
// });