FROM node

WORKDIR /app

COPY . .

EXPOSE 80
ENV SERVER_PORT=8080

CMD ["npm", "start"]
