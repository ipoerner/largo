############################################################
# Dockerfile template for tcpreplay v4.1.0
# <https://github.com/appneta/tcpreplay>
# note: invoke 'autogen.sh' twice before calling 'configure' (see <https://github.com/appneta/tcpreplay/issues/181>)
# note: build with `./configure --disable-local-libopts --disable-libopts-install`
############################################################

# Set the base image to Ubuntu
FROM largo/base-trusty

# File Author / Maintainer
MAINTAINER Ingmar Poerner

# Install tools and libs required for compiling the project
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    autoconf \
    autogen \
    automake \
    build-essential \
    libdnet-dev \
    libdumbnet-dev \
    libevent1-dev \
    libpcap-dev \
#   libpopt-dev \
    libtool

#RUN curl -SL http://www.monkey.org/~dugsong/fragroute/fragroute-1.2.tar.gz \
#    | tar -xz -C /tmp
#RUN cd /tmp/fragroute-1.2 && \
#    ./configure --prefix=/usr && \
#    sed -i 's/dnet.h/dumbnet.h/g' *.c *.h && \
#    make install
