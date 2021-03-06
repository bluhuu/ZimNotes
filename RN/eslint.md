## 1.安装eslint
    apm i linter
    apm i linter-eslint
    npm install eslint
    npm install -g eslint

## 2.安装eslint-plugin-react
    npm install eslint-plugin-react

## 3.安装eslint-plugin-react-native
    npm install eslint-plugin-react-native

## 4.在工程下增加配置文件
    eslint --init

#  5.如果用到了es6的新语法, 需要安装babel-eslint,不然会把箭头函数识别成错误
    npm install babel-eslint -D

## 5.编辑配置文件 .eslintrc.js
> 增加plugins,增加react-native规则
```js
module.exports = {
    "env": { "browser": true, "commonjs": true, "es6": true, "node": true },
    "extends": [
        "eslint:recommended", "plugin:react/recommended"
    ],
    "parser": "babel-eslint",
    "parserOptions": {
        "ecmaVersion": 6,
        "ecmaFeatures": {
            "experimentalObjectRestSpread": true,
            "jsx": true
        },
        "sourceType": "module"
    },
    "plugins": [
        "react", "react-native"
    ],
    "rules": {
        "indent": 0,
        "linebreak-style": 0,
        "quotes": [ "off", "single" ],
        "semi": [ "off", "never" ],
        "react-native/no-unused-styles": 2,
        "react-native/split-platform-components": 2,
        "no-console": 0,
        "prefer-promise-reject-errors": 0,
        "no-unused-vars":1,
        "no-undef":1,
    }
};
```
```json
.eslintrc.json
{
    //文件名 .eslintrc.json
    "env": {
        "browser": true,
        "es6": true,
        "node": true,
        "commonjs": true
    },
    "extends": "eslint:recommended",
    "installedESLint": true,
    "parserOptions": {
        "ecmaFeatures": {
            "experimentalObjectRestSpread": true,
            "jsx": true,
            "arrowFunctions": true,
            "classes": true,
            "modules": true,
            "defaultParams": true
        },
        "sourceType": "module"
    },
    "parser": "babel-eslint",
    "plugins": [
        "react"
    ],
    "rules": {
        "linebreak-style": [
            "error",
            "unix"
        ],
        //"semi": ["error", "always"],
        "no-empty": 0,
        "comma-dangle": 0,
        "no-unused-vars": 0,
        "no-console": 0,
        "no-const-assign": 2,
        "no-dupe-class-members": 2,
        "no-duplicate-case": 2,
        "no-extra-parens": [2, "functions"],
        "no-self-compare": 2,
        "accessor-pairs": 2,
        "comma-spacing": [2, {
            "before": false,
            "after": true
        }],
        "constructor-super": 2,
        "new-cap": [2, {
            "newIsCap": true,
            "capIsNew": false
        }],
        "new-parens": 2,
        "no-array-constructor": 2,
        "no-class-assign": 2,
        "no-cond-assign": 2
    }
}
```
