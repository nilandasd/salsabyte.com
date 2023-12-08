if [[ $NODE_ENV = "test" ]]
then
  npm run test:start
  exit $?
fi

if [[ $NODE_ENV = "dev" ]]
then
  npm run dev:start
fi

if [[ $NODE_ENV = "production" ]]
then
  npm start
fi
