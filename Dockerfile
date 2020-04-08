FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes unzip wget

ARG TERRAFORM_VERSION
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_386.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_386.zip
RUN mv terraform /usr/local/bin/
RUN rm terraform_${TERRAFORM_VERSION}_linux_386.zip

RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install
RUN rm -rf aws awscli-exe-linux-x86_64.zip

WORKDIR /app
COPY *.tf ./

CMD [ "terraform", "--version" ]
