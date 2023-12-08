if [[ $NODE_ENV = "test" ]]
then
  npm run test:build
  exit $?
fi

if [[ $NODE_ENV = "dev" ]]
then
  npm run dev:build
fi

if [[ $NODE_ENV = "production" ]]
then
  npm run prod:build
fi
