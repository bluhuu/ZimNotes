var htmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    // entry: './src/script/main.js',
    // entry: [ './src/script/main.js','./src/script/a.js'],
    entry:{
        main: './src/script/main.js',
        a: './src/script/a.js',
        b: './src/script/b.js',
        c: './src/script/b.js'
    },
    output: {
        path: __dirname + '/dist',
        filename: 'js/[name]-[chunkhash].js',
        publicPath: 'http://cdn.com/'
    },
    plugins:[
        new htmlWebpackPlugin({
            filename: 'a-[chunkhash].html',
            template:'index.html',
            excludeChunks: ['a'],
            // chunks: ['main', 'a'],
            // inject: 'head',
            inject: false,
            title: 'webpack is a.html',
            date: new Date(),
            minify: {
                removeComments: true,
                collapseWhitespace: true
            }
        }),
        new htmlWebpackPlugin({
            filename: 'b-[chunkhash].html',
            template:'index.html',
            excludeChunks: ['b'],
            // chunks: ['b'],
            // inject: 'head',
            inject: false,
            title: 'webpack is b.html',
            date: new Date(),
            minify: {
                removeComments: true,
                collapseWhitespace: true
            }
        }),
        new htmlWebpackPlugin({
            filename: 'c-[chunkhash].html',
            template:'index.html',
            chunks: ['main', 'c'],
            // inject: 'head',
            inject: false,
            title: 'webpack is c.html',
            date: new Date(),
            minify: {
                removeComments: true,
                collapseWhitespace: true
            }
        })
    ]
};
x
