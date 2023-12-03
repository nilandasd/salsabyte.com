FROM node

WORKDIR /app

COPY . .

RUN npm install

ENV SERVER_PORT=8080

CMD ["npm", "start"]
