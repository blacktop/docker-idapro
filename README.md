<p align="center">
  <a href="https://github.com/blacktop/docker-idapro"><img alt="IDA Logo" src="https://raw.githubusercontent.com/blacktop/docker-idapro/master/logo.png" height="100" /></a>
  <a href="https://github.com/blacktop/docker-idapro"><h3 align="center">docker-idapro</h3></a>
  <p align="center">IDA Pro Docker Image</p>
  <p align="center">
    <a href="https://hub.docker.com/r/blacktop/idapro/" alt="Docker Stars">
          <img src="https://img.shields.io/docker/stars/blacktop/idapro.svg" /></a>
    <a href="https://hub.docker.com/r/blacktop/idapro/" alt="Docker Pulls">
          <img src="https://img.shields.io/docker/pulls/blacktop/idapro.svg" /></a>
    <a href="https://hub.docker.com/r/blacktop/idapro/" alt="Docker Image">
          <img src="https://img.shields.io/badge/docker%20image-804MB-blue.svg" /></a>
    <a href="https://github.com/blacktop/docker-idapro/actions/workflows/docker-image.yml" alt="Docker CI">
          <img src="https://github.com/blacktop/docker-idapro/actions/workflows/docker-image.yml/badge.svg" /></a>
</p>

## Why?

For use as an [ipsw](https://github.com/blacktop/ipsw) pipeline.

## Dependencies

- [ubuntu:focal](https://hub.docker.com/_/ubuntu)

## Image Tags

```bash
REPOSITORY              TAG                 SIZE
blacktop/idapro         latest              804MB
blacktop/idapro         7.7                 804MB
```

## Getting Started

#### On macOS

1. Install XQuartz `brew install --cask xquartz`
2. `open -a XQuartz` and make sure you **"Allow connections from network clients"**
3. Now add the IP using Xhost with: `xhost + 127.0.0.1` or `xhost + $(ipconfig getifaddr en0)`
4. Start up IDA Pro

```bash
docker run --init -it --rm \
           --name idafree \
           -v `pwd`:/data \
           -e DISPLAY=host.docker.internal:0 \
           blacktop/idapro /data/bin
```

> **NOTE:** ⚠️ This is the IDA Free version and does not seem to be able to do heaadless analysis.

To persist settings across sessions:

```bash
docker run --init -it --rm \
           --name idafree \
           -v `pwd`:/data \
           -v $HOME/.idapro:/root/.idapro \
           -e DISPLAY=host.docker.internal:0 \
           blacktop/idapro /data/bin
```

## Build IDA Pro

1) Put a copy of the linux installer in the `pro` folder and name it `idapro.run`

```bash
IDAPW="your-install-pw-here" make build
```

2) Enter image container:

```bash
make ssh
```

```bash
root@add3b0fd6966:/ida# ./ida64
```

3) This will open the GUI; Now accept the license agreement and close the window.

4) Copy the `ida.reg` file to the `/data` directory and exit container:

```bash
root@add3b0fd6966:/ida# cp ~/.idapro/ida.reg /data
root@add3b0fd6966:/ida# exit
```

5) Move the `ida.reg` file to the `pro` folder:

```bash
mv data/ida.reg pro/
```

6) Rebuild the IDA Pro image with the new `ida.reg` file:

```bash
make build-reg
```

Congratulations!  You now have a registered IDA Pro image that you can perform headless analysis with 🎉

### Headless

Batch mode *(creates idb and asm files)*

```bash
docker run --init -it --rm \
           --name idapro \
           -v `pwd`:/data \
           --entrypoint=idat64 \ # idat64 uses less resources than ida64
           blacktop/idapro -B -P+ /data/bin
```

Autonomous mode

```bash
docker run --init -it --rm \
           --name idapro \
           -v `pwd`:/data \
           -v `pwd`/py:/ida/python \
           -v `pwd`/scripts:/ida/idc \ # add local scripts to IDA
           --entrypoint=idat64 \
           blacktop/idapro -A -Sanalysis.idc /data/bin
```

> **NOTE:** Here are a list of other CLI [options](https://www.hex-rays.com/products/ida/support/idadoc/417.shtml)

## Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/blacktop/docker-idapro/issues/new)

### License

MIT License Copyright (c) 2022 blacktop