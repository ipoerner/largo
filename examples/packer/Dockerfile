############################################################
# Dockerfile template for Packer 0.8.7
# <https://github.com/mitchellh/packer>
# note: 'git status' must be called initially before 'make'
############################################################
FROM largo/base-golang

MAINTAINER Ingmar Poerner <ingmar.poerner@rhebo.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    bzr \
    mercurial

# Install global dependency
RUN cd ${GOPATH} && \
    go get golang.org/x/tools/cmd/vet

# The 'golang' image uses /go as a global $GOPATH, which breaks with the Largo
# convention of mounting your project dir to /home/largo/<project>.
# 
# We thus let our custom $GOPATH be /home/largo/go and mount the project to
# $GOPATH/src/github.com/mitchellh/packer by customizing the $LARGO_ROOT
# environment variable.
RUN echo "export GOPATH=/home/largo/go" >> /etc/profile.d/largo.sh
RUN echo "export PATH=$PATH:/home/largo/go/bin" >> /etc/profile.d/largo.sh
ENV LARGO_ROOT /home/largo/go/src/github.com/mitchellh
