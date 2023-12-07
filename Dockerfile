FROM public.ecr.aws/docker/library/node:20

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

ARG NODE_ENV=test
ENV NODE_ENV=$NODE_ENV
ENV SERVER_PORT=8080

RUN bash tools/docker_build.sh

CMD ["bash", "tools/docker_entry.sh"]
