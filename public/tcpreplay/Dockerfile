############################################################
# Dockerfile template for tcpreplay v4.0.5
# Based upon Ubuntu 14.04 (Trusty Tahr)
# note: build with `./configure --disable-local-libopts --disable-libopts-install`
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Ingmar Poerner

# Locale settings
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Update the repository sources list
RUN apt-get update -y && apt-get upgrade -y

# Install common dev tools
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    curl \
    git \
    git-email \
    man \
    screen \
    ssh

# Install tools and libs required for compiling the project
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    autogen \
    build-essential \
    libdnet-dev \
    libdumbnet-dev \
    libevent1-dev \
    libpcap-dev

# Work-around for missing user mapping
# see <https://github.com/willb/dockerfiles/tree/master/java-dev/centos7-spark-uid>
RUN apt-get install -y --no-install-recommends whois
RUN useradd -m -s /bin/bash -p $(mkpasswd cargo) -G sudo cargo
COPY env/boot.sh /boot.sh
RUN chmod 755 /boot.sh
ENTRYPOINT /boot.sh

# Copy user configs
COPY config/* /home/cargo/

# Grab git completion script
ADD https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash /home/cargo/.git-completion.bash
RUN echo ". ~/.git-completion.bash" >>/home/cargo/.bashrc

# SSH agent forwarding
RUN echo "export SSH_AUTH_SOCK=/tmp/ssh_auth_sock" >>/home/cargo/.bashrc

#RUN curl -SL http://www.monkey.org/~dugsong/fragroute/fragroute-1.2.tar.gz \
#    | tar -xz -C /home/cargo
#RUN cd /home/cargo/fragroute-1.2 && \
#    ./configure --prefix=/usr && \
#    sed -i 's/dnet.h/dumbnet.h/g' *.c *.h && \
#    make install
