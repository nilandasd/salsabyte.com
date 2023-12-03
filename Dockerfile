FROM node

WORKDIR /app

COPY . .

RUN npm install

ENV SERVER_PORT=8080
ENV ENV=PROD

CMD ["npm", "start"]
