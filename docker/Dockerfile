FROM trzeci/emscripten-slim:sdk-tag-1.38.21-64bit

RUN apt-get -y update && \
    apt-get -y install vim sudo curl && \
    sudo -u emscripten /bin/sh -c "curl -fsS https://dlang.org/install.sh | bash -s ldc-1.12.0" && \
    (echo 'source $(~/dlang/install.sh ldc -a)' >> /home/emscripten/.bashrc)

ADD settings.json /var/lib/dub/settings.json
