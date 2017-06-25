# webpack读取入口文件，将它构建成bundle.js

```javascript
// main.js
document.write('Hello World');
```

```html
<html>
  <body>
    <script type="text/javascript" src="bundle.js"></script>
  </body>
</html>
```

```javascript
// webpack.config.js
module.exports = {
  entry: './main.js',
  output: {
    filename: 'bundle.js'
  }
};
```

$ webpack-dev-server

```bash
webpack hello.js hello.bundle.js --module-bind 'css=style-loader!css-loader' --progress --display-modules --display-reasons --watch
```
