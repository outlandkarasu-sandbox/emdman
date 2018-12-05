FROM trzeci/emscripten-slim:sdk-tag-1.38.21-64bit

RUN apt-get -y update
RUN apt-get -y install vim
RUN apt-get -y install sudo
RUN apt-get -y install curl
RUN sudo -u emscripten /bin/sh -c "curl -fsS https://dlang.org/install.sh | bash -s ldc"
RUN apt-get -y install build-essential libclang-dev libclang-3.9-dev
