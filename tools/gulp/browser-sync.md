```js
gulp.task('browser-sync', function() {
    browserSync.init({
        proxy: "127.0.0.1:8080"
    });
});
```

```bash
browser-sync start --proxy "127.0.0.1:8080" --files "d:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web/**/*.html,d:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web/**/*.js,d:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web/**/*.css"
```

```bash
browser-sync start --proxy "127.0.0.1:8080" --files "d:/apache/apache-tomcat-6.0.48/webapps/elink_eai_web/**/*"
```
