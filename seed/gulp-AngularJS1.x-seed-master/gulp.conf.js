module.exports = function() {

	var src = './src/';
	var build = './build/';

	var config = {
		src: src,
		build: build,
		tmp: './tmp/',
		index: src + 'index.html',
		template: src + 'app/**/*.html',
		js: src + '**/*.js',
		css: src + '**/*.css',
		jsOrder: [
			'**/app.js',
			'**/*.module.js',
			'**/*.js'
		],
		cssOrder: [
			'**/app.css',
			'**/*.module.css',
			'**/*.css'
		],
		proxyTarget: {
			local: 'http://localhost:8989',
			test: 'http://test-server:8989',
			product: 'http://product-server:8989'
		}
	};

	return config;
}();
