#web #web-bundler #javascript #ecmascript #dependency-manager #nodejs #browser #html #css 
# Example
## Sample `webpack.config.ts`
```TypeScript title='Sample webpack.config.ts'
// Generated using webpack-cli https://github.com/webpack/webpack-cli

import path from 'path';
import HtmlWebpackPlugin from 'html-webpack-plugin';
import MiniCssExtractPlugin from 'mini-css-extract-plugin';
import os from 'os';
import { type Configuration } from "webpack";
import { type Configuration as DevServerConfiguration } from "webpack-dev-server";
const isProduction = process.env.NODE_ENV === 'production';


const stylesHandler = isProduction ? MiniCssExtractPlugin.loader : 'style-loader';

const devServer: DevServerConfiguration = {
    open: true,
    host: 'localhost',
    port: 8001
};
const config: Configuration = {
    entry: './src/index.ts',
    output: {
        path: path.resolve(import.meta.dirname, 'dist'),
    },
    devServer,
    plugins: [
        new HtmlWebpackPlugin({
            template: 'index.html',
        }),

        // Add your plugins here
        // Learn more about plugins from https://webpack.js.org/configuration/plugins/
    ],
    module: {
        rules: [
            {
                test: /\.(ts|tsx)$/i,
                loader: 'ts-loader',
                exclude: ['/node_modules/'],
            },
            {
                test: /\.s[ac]ss$/i,
                use: [stylesHandler, 'css-loader', 'postcss-loader', 'sass-loader'],
            },
            {
                test: /\.css$/i,
                use: [stylesHandler, 'css-loader', 'postcss-loader'],
            },
            {
                test: /\.(eot|svg|ttf|woff|woff2|png|jpg|gif|webp)$/i,
                type: 'asset',
            },

            {
                test: /\.html$/i,
                use: ['html-loader'],
            },

            // Add your rules for custom modules here
            // Learn more about loaders from https://webpack.js.org/loaders/
        ],
    },
    resolve: {
        extensions: ['.tsx', '.ts', '.jsx', '.js', '...'],
    },
    parallelism: os.availableParallelism(),
    infrastructureLogging: {
        level: 'verbose'
    }
};

const bundle = () => {
    if (isProduction) {
        return {
            ...config,
            mode: 'production',
            plugins: [...(config.plugins || []), new MiniCssExtractPlugin()]
        }
    }
    return { ...config, mode: 'development' }
};

export default bundle as Configuration;
```
***
# References
1. https://webpack.js.org/