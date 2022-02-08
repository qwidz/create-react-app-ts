if [ ! -z $1 ]
then

echo "\033[37m[INFO] \033[32mCreating dir \033[35m$1"
mkdir $1 && cd $1

echo "\033[37m[INFO] \033[32mInitializing npm project"
npm init -y 1>/dev/null

echo "\033[37m[INFO] \033[32mInstalling dependencies:"

npm i --silent react react-dom;

npm i --silent --save-dev @babel/core @babel/register @babel/preset-env @babel/preset-react @babel/preset-typescript webpack webpack-cli webpack-dev-server style-loader css-loader typescript ts-loader @types/react @types/react-dom html-webpack-plugin fork-ts-checker-webpack-plugin eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-react eslint-webpack-plugin prettier eslint-config-prettier eslint-plugin-prettier;

echo "\033[37m[INFO] \033[32mFetching config files"
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/babel.config.json -o babel.config.json
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/webpack.config.ts -o webpack.config.ts
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/tsconfig.json -o tsconfig.json
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/.eslintrc.json -o .eslintrc.json
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/.prettierrc.json -o .prettierrc.json

echo "\033[37m[INFO] \033[32mFetching React files"
mkdir src public;
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/index.tsx -o src/index.tsx
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/App.tsx -o src/App.tsx
curl --silent https://raw.githubusercontent.com/qwidz/create-react-app-ts/main/index.html -o public/index.html

echo "\033[37m[INFO] \033[32mAdding a server startup script to package.json"
sed -i'.back' 's/"test": "echo \\"Error: no test specified\\" && exit 1"/"start": "webpack serve --config webpack.config.ts"/g' package.json;
rm package.json.back;

echo "\033[37m[INFO] \033[32mStarting server"
npm start

else
echo "[ERROR]: app name can't be blank"
fi
