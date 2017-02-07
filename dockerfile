# docker build ./ -t grafikart/elixir
FROM ubuntu:16.10

RUN apt-get update
RUN apt-get install -yq wget
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update 
RUN apt-get -yq install \
    esl-erlang \
    elixir \
    nodejs \
    npm
RUN ln -s /usr/bin/nodejs /usr/local/lib/node

# pageres CLI
RUN npm i -g pageres-cli

RUN mkdir /app

VOLUME /app

CMD ["bash"]