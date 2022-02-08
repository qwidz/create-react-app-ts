import HtmlWebpackPlugin from 'html-webpack-plugin'
import ESLintPlugin from 'eslint-webpack-plugin'

module.exports = {
  mode: 'development',
  entry: './src/index.tsx',
  devtool: 'source-map',
  output: {
    filename: 'bundle.js',
  },
  resolve: {
    extensions: ['.js', '.ts', '.tsx'],
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        exclude: /node_modules/,
        loader: 'ts-loader',
      },
      {
        test: /\.css$/i,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.(svg)$/i,
        use: [{ loader: 'file-loader' }],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({ template: './public/index.html' }),
    new ESLintPlugin({
      extensions: ['ts', 'tsx'],
    }),
  ],
  devServer: {
    port: 3000,
    open: true,
  },
}
