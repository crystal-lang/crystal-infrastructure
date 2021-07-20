#!/bin/sh
set -xe

version=1.0.0
tag=jhass/crystal:$version-build
static_build=crystal-$version-aarch64-alpine-linux-musl
tarball=$static_build.tar.gz
[ ! -f $tarball ] && wget https://dev.alpinelinux.org/archive/crystal/$tarball
[ ! -d $static_build ] && tar xf $tarball

docker buildx build \
  --platform linux/arm64/v8 \
  --tag $tag \
  --build-arg crystal=$static_build/bin/crystal \
  .
docker push $tag
