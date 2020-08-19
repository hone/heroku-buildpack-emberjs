FROM hone/mruby-cli:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:george-edison55/cmake-3.x && \
    apt-get update && \
    apt-get upgrade -y cmake
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install g++-4.9 gcc-4.9 clang-3.6 -y && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9

RUN apt-get update && \
  apt-get install python -y
RUN mkdir -p /opt && \
  cd /opt && \
  curl -s "https://nodejs.org/dist/v5.7.0/node-v5.7.0-linux-x64.tar.xz" -o - | tar xJ
ENV PATH /opt/node-v5.7.0-linux-x64/bin:$PATH
