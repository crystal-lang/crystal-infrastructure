FROM alpine:3.12.0

RUN \
  apk add --update --no-cache --force-overwrite \
    build-base git gc-dev llvm-dev libevent-dev pcre-dev zlib-dev \
    libxml2-dev yaml-dev openssl-dev gmp-dev zlib-dev

ARG crystal
COPY ${crystal} /usr/bin/crystal

RUN adduser -D crystal
USER crystal
CMD ["/bin/sh"]
