#npm
## 配置
* smart-npm
```bash
npm install --global smart-npm --registry=https://registry.npm.taobao.org/
where snpm
npm uninstall --global smart-npm
```
## npm常用命令
1. npm -h							    查看npm命令的帮助信息
2. npm init						        会引导你创建一个package.json文件，包括名称、版本、作者这些信息等
3. npm __rebuild__ moduleName			用于更改包内容后进行重建
4. npm -v/--version					    查看npm版本信息
5. npm __info__ <pkg> version			查看某个模块最新发布版本信息，如npm info underscore version
6. npm __search__ <keyword>				查找与keyword匹配的模块信息
7. npm __view__ <pkg> version			查看一个包的最新发布版本
8. npm install <pkg>					安装指定模块
9. npm install <pkg>@version			安装指定版本的模块
10. npm install <pkg> __--save__		多数情况下会安装最新版本的包,安装包的同时自动更新package.json的dependencies
11. npm install <pkg> --save-dev		多数情况下会安装最新版本的包,安装包的同时自动更新package.json的devDependencies
12. npm install <pkg> --save-optional	多数情况下会安装最新版本的包,安装包的同时自动更新package.json的optionalDependencies
13. npm install <pkg> --save-exact		Saved dependencies will be configured with an exact version rather than using npm's default semver range operator.
14. npm install <name> __-g__ 			将包安装到全局环境中
15. npm __update__ moduleName			更新node模块
16. npm __uninstall__ moudleName		卸载node模块
17. npm root						    查看当前包的安装路径
18. npm root -g					        查看全局的包的安装路径
19. npm outdated					    检查包是否已经过时，此命令会列出所有已经过时的包，可以及时进行包的更新
20. npm prune 						    删掉
21. npm list --depth=0                  查看所有高级的npm moudles
22. npm list --depth=0 -global          查看所有全局安装的模块

