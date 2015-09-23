FROM largo/base-golang

MAINTAINER Ingmar Poerner <ingmar.poerner@rhebo.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    bzr \
    mercurial

# Install global dependency
RUN cd ${GOPATH} && \
    go get golang.org/x/tools/cmd/vet

# The golang image uses /go as a global $GOPATH, which breaks with the Largo
# convention of mounting your project dir to /home/largo/<project>.
# 
# We thus let our custom $GOPATH be a Docker volume /home/largo/go and mount the
# project into $GOPATH/src/github.com/mitchellh/packer by defining a custom
# $LARGO_ROOT environment varible.
VOLUME /home/largo/go
RUN echo "export GOPATH=/home/largo/go" >> /home/largo/.bashrc
RUN echo "export PATH=$PATH:/home/largo/go/bin" >> /home/largo/.bashrc
ENV LARGO_ROOT /home/largo/go/src/github.com/mitchellh
