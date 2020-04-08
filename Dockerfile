FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes unzip wget

RUN wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_386.zip
RUN unzip terraform_0.12.24_linux_386.zip
RUN mv terraform /usr/local/bin/

CMD [ "terraform", "--version" ]
