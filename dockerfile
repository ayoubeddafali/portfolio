# docker build ./ -t grafikart/elixir
FROM ubuntu:16.10

# Update
RUN apt-get update
RUN apt-get install -yq wget

###
# Elixir
###
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update 
RUN apt-get -yq install \
    esl-erlang \
    elixir \
    zsh \
    sudo
RUN chsh -s /usr/bin/zsh

###
# NODEJS
###
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 7.5.0
RUN wget https://github.com/taaem/nodejs-linux-installer/releases/download/v0.3/node-install.sh \
 && chmod +x ./node-install.sh \
 && ./node-install.sh

RUN mkdir /app

# VOLUME
VOLUME /app

# PORTS
EXPOSE 4000
EXPOSE 3003

# ZSH 
CMD /usr/bin/zsh
ENTRYPOINT /usr/bin/zsh