FROM node:13-alpine

WORKDIR /app

COPY package.json ./
RUN npm install

COPY *.js ./

ENV PORT 3000

EXPOSE ${PORT}

CMD [ "npm", "run", "start" ]
