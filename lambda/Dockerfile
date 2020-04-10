FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes zip

WORKDIR /app
COPY *.js ./

CMD ["zip", "../example.zip", "index.js"];
