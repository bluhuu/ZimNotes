## packagecontrol
```bash
install with "ctrl+`":
import urllib.request,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)

1. ConvertToUTF8
2. Emmet Emmet 提供了一种非常简练的语法规则，然后立刻生成对应的 HTML 结构或者 CSS 代码，同时还有多种实用的功能帮助进行前端开发。
3. Sublime​Linter——代码校验插件，支持多种语言；
4. HTML5HTML5 bundle;
5. Alignment 代码对齐；
6. Bracket​Highlighter 括号高亮匹配；
7. Git 整合 Git 功能的插件；
8. jQuery 智能提示jQuery代码；
9. LESS LESS 代码高亮；
10. Js​Format JavaScript代码格式化；
11. Tag HTML/XML标签缩进、补全和校验；
12. LiveReload 即时刷新页面；
13. Pretty JSON JSON美化；
14. Can I Use 查询 CSS 属性兼容性；
15. Coffee​Script Coffee​Script 代码高亮、校验和编译等；
16. Color​Picker 跨平台取色器插件；
```
