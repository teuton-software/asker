FROM ruby:3.1

LABEL authors="teuton.software@proton.me"

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y vim tree
RUN gem install asker-tool -v 2.5.8

EXPOSE 80

WORKDIR /opt
CMD ["/bin/bash"]
