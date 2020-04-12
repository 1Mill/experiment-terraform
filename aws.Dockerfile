FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes wget unzip

# Install AWS
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install
RUN rm -rf aws awscli-exe-linux-x86_64.zip

# Install Docker
RUN apt-get install --yes \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"
RUN apt-get update && apt-get install --yes docker-ce docker-ce-cli containerd.io

WORKDIR /app
ARG FOLDER
COPY ${FOLDER}/*.* ${FOLDER}/Dockerfile ./

CMD [ "aws", "--version" ]
