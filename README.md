<p align="center">
  <a href="https://github.com/blacktop/docker-idapro"><img alt="IDA Logo" src="https://raw.githubusercontent.com/blacktop/docker-idapro/master/logo.png" height="140" /></a>
  <a href="https://github.com/blacktop/docker-idapro"><h3 align="center">docker-idapro</h3></a>
  <p align="center">IDA Pro Free Docker Image</p>
  <p align="center">
    <a href="https://hub.docker.com/r/blacktop/idapro/" alt="Docker Stars">
          <img src="https://img.shields.io/docker/stars/blacktop/idapro.svg" /></a>
    <a href="https://hub.docker.com/r/blacktop/idapro/" alt="Docker Pulls">
          <img src="https://img.shields.io/docker/pulls/blacktop/idapro.svg" /></a>
    <a href="https://hub.docker.com/r/blacktop/idapro/" alt="Docker Image">
          <img src="https://img.shields.io/badge/docker%20image-1.41GB-blue.svg" /></a>
    <a href="https://github.com/blacktop/docker-idapro/actions/workflows/docker-image.yml" alt="Docker CI">
          <img src="https://github.com/blacktop/docker-idapro/actions/workflows/docker-image.yml/badge.svg" /></a>
</p>

## Why?

For use in a [ipsw](https://github.com/blacktop/ipsw) pipeline.

## Dependencies

- [ubuntu:trusty](https://hub.docker.com/_/ubuntu)

## Image Tags

```bash
REPOSITORY               TAG                 SIZE
blacktop/idapro         latest              1.41GB
blacktop/idapro         7.7                 1.41GB
```

## Getting Started

### Headless

```bash
$ docker run --init -it --rm \
             --name idapro \
             -v `pwd`:/data \
             blacktop/idapro -A /data/bin
```

## Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/blacktop/docker-idapro/issues/new)

### License

MIT License Copyright (c) 2022 blacktop