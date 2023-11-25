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

        test: /\.css$/i,
        use: ['style-loader', 'css-loader'],
      },
    ],
  },
  resolve: {
    extensions: ['.ts', '.js', '.css'],
  },
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'public/dist'),
  },
};
