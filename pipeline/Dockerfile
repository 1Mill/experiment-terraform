FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install --yes \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common \
	unzip \
	wget

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"
RUN apt-get update
RUN apt-get install --yes \
	containerd.io \
	docker-ce \
	docker-ce-cli

# Install AWS
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install
RUN rm -rf aws awscli-exe-linux-x86_64.zip

# Install terraform
ARG TERRAFORM_VERSION
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_386.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_386.zip
RUN mv terraform /usr/local/bin/
RUN rm terraform_${TERRAFORM_VERSION}_linux_386.zip

WORKDIR /app
COPY . .

CMD [ "echo", "Finished" ]
