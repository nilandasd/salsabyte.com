if [[ $NODE_ENV = "test" ]]
then
  npm run test:build
fi

if [[ $NODE_ENV = "dev" ]]
then
  npm run dev:build
fi

if [[ $NODE_ENV = "production" ]]
then
  npm run prod:build
fi
