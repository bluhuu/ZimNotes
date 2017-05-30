# webpack

> $ npm i -g webpack webpack-dev-server

## 然后克隆本仓库再安装依赖
> $ git clone [[https://github.com/ruanyf/webpack-demos|git@github.com:ruanyf/webpack-demos.git]]  
> $ cd webpack-demos  
> $ npm install  

=== 现在你可以试着跑demo*目录下面的源码文件了
$ cd demo01
$ webpack-dev-server
[[http://127.0.0.1:8080|在你的浏览器里面访问http://127.0.0.1:8080]]

===== 前言: 什么是 Webpack

=== webpack是类似Grunt和Glup的前端构建工具,他可以像Browserify一样打包模块文件,但更强大.
$ browserify main.js > bundle.js
# 类似于
$ webpack main.js bundle.js

=== webpack.config.js是webpack的配置文件
// webpack.config.js
module.exports = {  
  entry: './main.js',  // 入口文件
  output: {
	filename: 'bundle.js'  //输出文件
  }
};

=== 当你创建了 webpack.config.js之后，你就可以不带参数，直接执行Wecpack了
$ webpack

=== 下面这些命令你应该了解下
* webpack – 在开发时构建一次
* webpack -p – 再生产环境中构建 (minification微小)
* webpack --watch – 监听文件改动，持续构建
* webpack -d – 引用源码的映射
* webpack --colors – for making things pretty

=== 创建要投入生产的应用，你可以在package.json文件中添加 scripts字段，如下：
// package.json
{
  // ...
  "scripts": {
	"dev": "webpack-dev-server --devtool eval --progress --colors",
	"deploy": "NODE_ENV=production webpack -p"
  },
  // ...
}

[[+Demo01 入口文件(source)|Demo01: 入口文件(source)]]
[[+Demo02 多个入口文件 (source)|Demo02: 多个入口文件 (source)]]
[[+Demo03 Babel-loader (source)|Demo03: Babel-loader (source)]]
[[+Demo04 CSS-loader (source)|Demo04: CSS-loader (source)]]
[[+Demo05 Image loader (source)|Demo05: Image loader (source)]]
[[+Demo06 CSS模块 (source)作用域|Demo06: CSS模块 (source)作用域]]
[[+Demo07 UglifyJs插件 (source)|Demo07: UglifyJs插件 (source)]]
[[+Demo08 环境标记 (source)只在开发环境下运行的代码|Demo08: 环境标记 (source)只在开发环境下运行的代码]]
[[+Demo09 代码分离(source)|Demo09: 代码分离(source)]]
[[+Demo10 使用bundle-loader分离代码(source)|Demo10: 使用bundle-loader分离代码(source)]]
[[+Demo11 共用代码块(source)|Demo11: 共用代码块(source)]]
[[+Demo12 第三方代码块 (source)|Demo12: 第三方代码块 (source)]]
[[+Demo13 暴露全局变量(source)|Demo13: 暴露全局变量(source)]]
[[+Demo14 React hot loader(source)|Demo14: React hot loader(source)]]
[[+Demo15 React router (source)|Demo15: React router (source)]]

