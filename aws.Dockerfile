FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes wget unzip

RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install
RUN rm -rf aws awscli-exe-linux-x86_64.zip

CMD [ "aws", "--version" ]
