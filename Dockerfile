FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y curl wget android-tools-adb supervisor
RUN apt-get install -y gcc make g++ pkg-config

ADD ./stf/protobuf-2.6.1.tar.gz /tmp
RUN cd /tmp/protobuf-2.6.1 && ./configure && make && make install

COPY ./stf/libsodium-1.0.15.tar.gz /tmp
COPY ./stf/zeromq-4.2.2.tar.gz /tmp
COPY ./stf/GraphicsMagick-1.3.26.tar.gz /tmp
RUN cd /tmp && tar -zxvf libsodium-1.0.15.tar.gz && cd libsodium-1.0.15 && ./configure && make && make install
RUN cd /tmp && tar -zxvf zeromq-4.2.2.tar.gz && cd zeromq-4.2.2 && ./configure && make && make install && ldconfig
RUN cd /tmp && tar -zxvf GraphicsMagick-1.3.26.tar.gz && cd GraphicsMagick-1.3.26 && ./configure && make && make install

ENV PATH /opt/node-v8.7.0-linux-x64/bin/:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ADD ./stf/node-v8.7.0-linux-x64.tar.gz /opt
RUN apt-get install -y yasm && npm install gyp stf please-update-dependencies --unsafe-perm --verbose -g --registry=https://registry.npm.taobao.org
RUN ln -s /opt/node-v8.7.0-linux-x64/lib/node_modules/stf/bin/stf /usr/bin/stf && rm -rf /tmp/*

ENV RETHINKDB_PORT_28015_TCP 'tcp://172.16.35.147:28015'
EXPOSE 5037 5555 7100
CMD ["bash", "-c", "adb start-server && stf local"]

