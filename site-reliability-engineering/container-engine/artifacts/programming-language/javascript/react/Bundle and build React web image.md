#nodejs #nodejs20 #nodejs18  #react #web-bundler #webpack #nginx #web-server #web 
# Nginx
## Debian-based nginx
### Node.js 20
```Nginx title='Nginx web server configuration'
server {
    listen 3546;
    server_name localhost;

    root /usr/share/nginx/html;
    index home.template.html;

    location / {
        try_files $uri $uri/ /home.template.html;
    }

    location ~* \.(css|js|ico|png|jpg|jpeg|gif|svg|eot|ttf|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public";
    }
}
```

```JavaScript title='webpack.config.js'
const appConfig = require('./package'),
    fs = require('fs'),
    path = require('path');

const entry = {};
fs.readdirSync('./view').forEach(folder => {
    if (fs.lstatSync('./view/' + folder).isDirectory() && fs.existsSync('./view/' + folder + '/' + folder + '.jsx')) {
        entry[folder] = path.join(__dirname, 'view', folder, folder + '.jsx');
    }
});
const genHtmlWebpackPlugins = (isProductionMode) => {
    let HtmlWebpackPlugin = isProductionMode ? require(require.resolve('html-webpack-plugin', { paths: [require.main.path] })) : require('html-webpack-plugin'),
        plugins = [],
        htmlPluginOptions = {
            inject: false,
            hash: true,
            minifyOptions: { removeComments: true, collapseWhitespace: true, conservativeCollapse: true },
            title: appConfig.title,
            keywords: appConfig.keywords,
            version: appConfig.version,
            description: appConfig.description
        };
    fs.readdirSync('./view').forEach(filename => {
        const template = `./view/${filename}/${filename}.pug`;
        if (filename != '.DS_Store' && fs.existsSync(template) && fs.lstatSync(template).isFile()) {
            const options = Object.assign({ template, filename: filename + '.template.html' }, htmlPluginOptions);
            plugins.push(new HtmlWebpackPlugin(options));
        }
    });
    return plugins;
};

module.exports = (env, argv) => ({
    entry,
    output: {
        path: path.join(__dirname, 'public'),
        publicPath: '/',
        filename: 'js/[name].[contenthash].js',
    },
    plugins: [
        ...genHtmlWebpackPlugins(argv.mode === 'production'),
    ],
    module: {
        rules: [
            { test: /\.pug$/, loader: '@webdiscus/pug-loader', },
            { test: /\.css$/i, use: ['style-loader', 'css-loader'] },
            {
                test: /\.s[ac]ss$/i, use: ['style-loader', 'css-loader', 'sass-loader']
            },
            {
                test: /\.jsx?$/, exclude: /node_modules/,
                use: ['thread-loader', {
                    loader: 'babel-loader',
                    options: {
                        plugins: ['@babel/plugin-syntax-dynamic-import', '@babel/plugin-proposal-class-properties'],
                        presets: ['@babel/preset-env', '@babel/preset-react'],
                        cacheDirectory: true,
                        cacheCompression: false,
                    },
                }]
            },
            {
                test: /\.(eot|.svg|ttf|woff|woff2)(\?v=\d+\.\d+\.\d+)?$/,
                use: {
                    loader: 'url-loader',
                    options: { limit: 10000 },
                },
            },
            {
                test: /\.svg$/,
                use: {
                    loader: 'svg-url-loader',
                    options: { limit: 10000 },
                },
            },
        ]
    },
    // stats: { warnings: false },
    devServer: {
        port: appConfig.port + 1,
        compress: true,
        historyApiFallback: true,
        open: true,
        hot: true,
    },
    resolve: {
        alias: { exceljsFE: path.resolve(__dirname, 'node_modules/exceljs/dist/exceljs.min'), },
        modules: [path.resolve(__dirname, './'), 'node_modules'],
        extensions: ['.js', '.jsx', '.json'],

    },
    optimization: { minimize: true },
    performance: {
        hints: false,
        maxEntrypointSize: 512000,
        maxAssetSize: 512000
    },
    target: 'web'
});
```

```Dockerfile title='Bundle and build React web image on Nginx web server' hl=37-38
FROM docker.io/library/node:20-trixie-slim AS builder

USER node
WORKDIR /build

COPY --chown=node . .

RUN npm ci
# RUN npm run lint:fix
RUN npm run build-webpack

FROM docker.io/library/nginx:stable AS runtime
USER root

#RUN chown -R nginx:nginx /usr/share/nginx/html && \
#    chown -R nginx:nginx /var/log/nginx && \
#    chown -R nginx:nginx /etc/nginx/conf.d

RUN <<EOT bash
  set -ex
  
  apt-get update
  apt-get upgrade -y
  apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    gnupg \
    tzdata \
    python3
  apt-get clean
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
  ln -sf /usr/share/zoneinfo/UTC /etc/localtime
EOT

#USER nginx
COPY --from=builder --chown=nginx:nginx /build/public /usr/share/nginx/html
COPY --chown=nginx:nginx ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3546
CMD ["nginx", "-g", "daemon off;"]
```
- The image recorded is 295 MB.
- ![[assets/Pasted image 20260117141624.png]]
***
# References
1. https://github.com/nginx/docker-nginx/blob/a306285ea2e4267c63ca539c66e8bc242bdce917/stable/debian/Dockerfile for Debian-based Nginx stable image.
2. 