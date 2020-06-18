FROM ubuntu:bionic

ARG crystal
COPY ${crystal} /usr/bin/crystal

RUN \
  apt-get update && \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y tzdata gcc pkg-config libssl-dev libxml2-dev libyaml-dev libgmp-dev git make \
                     libpcre3-dev libevent-dev libgc-dev build-essential llvm-8 lld-8 libedit-dev gdb && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /usr/bin/ld.lld-8 /usr/bin/ld.lld

RUN useradd -ms /bin/sh crystal
USER crystal
CMD ["/bin/sh"]