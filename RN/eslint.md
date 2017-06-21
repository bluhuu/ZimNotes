## 1.安装eslint
    npm install eslint
    npm install -g eslint

## 2.安装eslint-plugin-react
    npm install eslint-plugin-react

## 3.安装eslint-plugin-react-native
    npm install eslint-plugin-react-native

## 4.在工程下增加配置文件
    eslint --init

## 5.编辑配置文件 .eslintrc.js
> 增加plugins,增加react-native规则
```js
module.exports = {
    "env": {
        "browser": false,
        "commonjs": true,
        "es6": true,
        "node": true
    },
    "extends": ["eslint:recommended","plugin:react/recommended"],
    "parserOptions": {
        "ecmaFeatures": {
            "experimentalObjectRestSpread": true,
            "jsx": true
        },
        "sourceType": "module"
    },
    "plugins": [
        "react",
        "react-native"
    ],
    "rules": {
        "indent": [ "error", 4 ],
        "linebreak-style": [ "error", "unix" ],
        "quotes": [ "error", "single" ],
        "semi": [ "error", "always" ],
        "react-native/no-unused-styles": 2,
        "react-native/split-platform-components": 2
    }
};
```
```js
module.exports = {
    "env": {
        "browser": true,
        "commonjs": true,
        "es6": true,
        "node": true
    },
    "extends": [
        "eslint:recommended", "plugin:react/recommended"
    ],
    "parserOptions": {
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
        "linebreak-style": [ "error", "windows" ],
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
