############################################################
# Dockerfile for c-capnproto compilation
# <https://github.com/jmckaskill/c-capnproto>
# Based upon Ubuntu 14.04 (Trusty Tahr)
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

# Install common tools
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    git \
    git-email \
    man \
    screen \
    ssh

# Install tools and libs required for compiling the project
RUN apt-get update -y && apt-get install -y build-essential --no-install-recommends \
    libgtest-dev \
    make

# Work-around for missing user mapping
# see <https://github.com/willb/dockerfiles/tree/master/java-dev/centos7-spark-uid>
RUN apt-get install -y --no-install-recommends whois
RUN useradd -m -s /bin/bash -p $(mkpasswd dockerdev) -G sudo dockerdev
COPY env/boot.sh /boot.sh
RUN chmod 755 /boot.sh
ENTRYPOINT /boot.sh

# Copy user configs
COPY config/* /home/dockerdev/

# Grab git completion script
ADD https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash /home/dockerdev/.git-completion.bash
RUN echo ". ~/.git-completion.bash" >>/home/dockerdev/.bashrc

# SSH agent forwarding
RUN echo "export SSH_AUTH_SOCK=/tmp/ssh_auth_sock" >>/home/dockerdev/.bashrc
