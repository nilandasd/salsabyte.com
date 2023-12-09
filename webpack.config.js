const path = require('path');

module.exports = {
  entry: './public/scripts/index.ts',
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
      {

        test: /\.s[ac]ss$/,
        use: ['style-loader', 'css-loader', "sass-loader"],
      },
    ],
  },
  resolve: {
    extensions: ['.ts', '.js', '.scss'],
  },
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'public/dist'),
  },
};
