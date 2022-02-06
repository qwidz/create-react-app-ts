if [ ! -z $1 ]
then
  echo "[INFO] creating app directory"
  mkdir $1 && cd app;
  echo "[INFO] initializing npm project"
  npm init -y 1>/dev/null;
  echo "[INFO] installing babel"
  npm i --silent --save-dev @babel/core @babel/register @babel/preset-env @babel/preset-react @babel/preset-typescript;
  echo "[INFO] creating babel.config"
  echo "{
  \"presets\": [
    \"@babel/preset-env\",
    \"@babel/preset-react\",
    \"@babel/preset-typescript\"
  ]
}" > "babel.config.json";
echo "[INFO] installing webpack"
npm i --silent --save-dev webpack webpack-cli webpack-dev-server style-loader css-loader typescript ts-loader
echo "[INFO] creating webpack.config";
echo "import HtmlWebpackPlugin from 'html-webpack-plugin'
import ESLintPlugin from 'eslint-webpack-plugin'
module.exports = {
  mode: 'development',
  entry: './src/index.tsx',
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
}" > "webpack.config.ts";
echo "[INFO] creating tsconfig";
echo "{
  \"compilerOptions\": {
    // Base
    \"target\": \"es5\",
    \"moduleResolution\": \"node\",
    \"lib\": [
      \"dom\",
      \"es5\",
      \"ScriptHost\"
    ],
    \"outDir\": \"dist\",
    \"esModuleInterop\": true,
    \"forceConsistentCasingInFileNames\": true,
    \"allowUmdGlobalAccess\": true,
    \"resolveJsonModule\": true,
    \"jsx\": \"react\",
    \"strict\": true,
    // Linter Checks
    \"noPropertyAccessFromIndexSignature\": true,
    \"noUnusedParameters\": true,
    // Advanced
    \"allowUnreachableCode\": true,
  },
  \"include\": [
    \"src\"
  ]
}" > tsconfig.json;
echo "[INFO] installing react react-dom"
npm i --silent react react-dom;
echo "[INFO] installing react react-dom types"
npm i --silent --save-dev @types/react @types/react-dom;
echo "[INFO] installing webpack plugins"
npm i --silent --save-dev html-webpack-plugin fork-ts-checker-webpack-plugin;
echo "[INFO] installing eslint"
npm i --silent --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-react eslint-webpack-plugin;
echo "[INFO] installing prettier"
npm i --silent --save-dev prettier eslint-config-prettier eslint-plugin-prettier;

sed -i'.back' 's/"test": "echo \\"Error: no test specified\\" && exit 1"/"start": "webpack serve --config webpack.config.ts"/g' package.json;
rm package.json.back;

echo "[INFO] creating index.html index.tsx App.tsx"

mkdir src public;

echo "<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>React</title>
</head>
<body>
  <div id="root"></div>
</body>
</html>" > public/index.html;

echo "import React from 'react'
import ReactDOM from 'react-dom'
import App from './App'

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
)" > src/index.tsx;

echo "import React from 'react'

const App: React.FC = () => <h1>Hello, world</h1>

export default App" > src/App.tsx;

echo "[INFO] creating eslintrc"

echo "{
  \"parser\": \"@typescript-eslint/parser\",
  \"extends\": [
    \"plugin:react/recommended\",
    \"plugin:@typescript-eslint/eslint-recommended\"
  ],
  \"parserOptions\": {
    \"ecmaVersion\": \"latest\",
    \"sourceType\": \"module\",
    \"ecmaFeatures\": {
      \"jsx\": true
    }
  },
  \"rules\": {
    \"consistent-return\": \"error\",
    \"no-fallthrough\": \"error\",
    \"no-unused-vars\": \"warn\",
    \"no-unreachable\": \"warn\",
    \"prettier/prettier\": \"error\"
  },
  \"settings\": {
    \"react\": {
      \"version\": \"detect\"
    }
  },
  \"plugins\": [
    \"eslint-plugin-prettier\"
  ]
}" > .eslintrc.json;

echo "[INFO] creating prettierrc"

echo "{
  \"trailingComma\": \"es5\",
  \"tabWidth\": 2,
  \"semi\": false,
  \"singleQuote\": true,
  \"printWidth\": 80
}" > .prettierrc.json;

echo "[INFO] starting server"

npm start;
else
  echo "[ERROR]: app name can't be blank"
fi
