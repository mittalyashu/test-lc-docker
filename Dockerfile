FROM ubuntu:20.04

# The installer can run interactive config and will attempt that and fail. To suppress those and have packages that have interactive config with their defaults.
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -yq \
		git \
		curl \
	&& rm -rf /tmp/*

RUN useradd --user-group --create-home --groups sudo lc

WORKDIR /home/lc
USER lc

ENV NODE_VERSION=12.18.4

# Install nvm
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash \
    && bash -c ". .nvm/nvm.sh \
        && nvm install $NODE_VERSION \
        && nvm alias default $NODE_VERSION \
        && npm install -g yarn"
