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