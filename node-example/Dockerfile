FROM node:13-alpine

COPY package.json ./
RUN npm install

COPY *.js ./

CMD [ "npm", "run", "start" ]
