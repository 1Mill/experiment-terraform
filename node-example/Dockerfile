FROM node:13-alpine

WORKDIR /app

COPY package.json ./
RUN npm install

COPY *.js ./

ENV PORT ${PORT}

CMD [ "npm", "run", "start" ]
