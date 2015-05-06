############################################################
# Dockerfile template for tcpreplay v4.0.5
# <https://github.com/appneta/tcpreplay>
# note: build with `./configure --disable-local-libopts --disable-libopts-install`
############################################################

# Set the base image to Ubuntu
FROM cargo-base-trusty

# File Author / Maintainer
MAINTAINER Ingmar Poerner

# Install tools and libs required for compiling the project
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    autogen \
    build-essential \
    libdnet-dev \
    libdumbnet-dev \
    libevent1-dev \
    libpcap-dev

# Copy user configs
COPY config/* /home/cargo/

#RUN curl -SL http://www.monkey.org/~dugsong/fragroute/fragroute-1.2.tar.gz \
#    | tar -xz -C /home/cargo
#RUN cd /home/cargo/fragroute-1.2 && \
#    ./configure --prefix=/usr && \
#    sed -i 's/dnet.h/dumbnet.h/g' *.c *.h && \
#    make install
