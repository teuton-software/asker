FROM ubuntu:latest

LABEL authors="teuton.software@proton.me"

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y vim
RUN apt-get install -y tree
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y ruby-dev
RUN apt-get install -y ruby

# RUN gem install asker-tool

WORKDIR /opt
CMD ["/bin/bash"]
