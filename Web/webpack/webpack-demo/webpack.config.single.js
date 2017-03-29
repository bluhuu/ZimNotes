var htmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    // entry: './src/script/main.js',
    // entry: [ './src/script/main.js','./src/script/a.js'],
    entry:{
        main: './src/script/main.js',
        a: './src/script/a.js'
    },
    output: {
        path: __dirname + '/dist',
        filename: 'js/[name]-[chunkhash].js',
        publicPath: 'http://cdn.com/'
    },
    plugins:[
        new htmlWebpackPlugin({
            filename: 'index-[chunkhash].html',
            template:'index.html',
            // inject: 'head',
            inject: false,
            title: 'webpack is good',
            date: new Date(),
            minify: {
                removeComments: true,
                collapseWhitespace: true
            }
        })
    ]
};
if (true) {

} else {

}

