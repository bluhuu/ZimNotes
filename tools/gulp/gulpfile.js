var gulp = require('gulp');
var changed = require('gulp-changed');
var watch = require('gulp-watch');

gulp.task('default',function(){
    var src  = 'D:/Workspace/elink_eai_web/WebRoot/**/*',
    dist = 'D:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web';
    gulp.src(src).pipe(changed(dist)).pipe(gulp.dest(dist));
    return gulp.watch(src, function(event) {
         //可加入压缩等其他任务
         gulp.src(src).pipe(changed(dist)).pipe(gulp.dest(dist));
    });
});
