FROM node:20

WORKDIR /app

COPY . .

RUN npm install
RUN npm run prep

ENV SERVER_PORT=8080
ENV NODE_ENV=production

CMD ["npm", "start"]
