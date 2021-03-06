FROM ubuntu:16.04
MAINTAINER Erik Wickstrom <erik@erikwickstrom.com>

# install build dependencies
RUN apt-get -qq update && apt-get -qqy install iputils-ping libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make curl git-core luarocks

# build/install OpenResty
ENV SRC_DIR /opt
ENV OPENRESTY_VERSION 1.11.2.5
ENV OPENRESTY_PREFIX /opt/openresty
ENV LAPIS_VERSION 1.6.0

RUN cd $SRC_DIR && curl -LOs https://openresty.org/download/openresty-$OPENRESTY_VERSION.tar.gz \
 && tar xzf openresty-$OPENRESTY_VERSION.tar.gz && cd openresty-$OPENRESTY_VERSION \
 && ./configure --prefix=$OPENRESTY_PREFIX \
 --with-luajit \
 --with-http_realip_module \
 --with-http_stub_status_module \
 && make && make install && rm -rf openresty-$OPENRESTY_VERSION*

RUN luarocks install --server=http://rocks.moonscript.org/manifests/leafo lapis $LAPIS_VERSION
RUN luarocks install moonscript
RUN luarocks install lapis-console
RUN luarocks install luacrypto
RUN luarocks install inspect

WORKDIR $OPENRESTY_PREFIX/nginx/conf

ENV LAPIS_OPENRESTY $OPENRESTY_PREFIX/nginx/sbin/nginx

EXPOSE 8080
EXPOSE 80

# Setup sample lapis project.
COPY webapp/ .

RUN make all

# LAPIS_OPENRESTY=/opt/openresty/nginx/sbin/nginx lapis server production
ENTRYPOINT ["lapis"]
CMD ["server", "development"]