# ca-certificates

## Quick reference

This is a demo for `How to add CA root certification (self-signed)` use openssl and update-ca-certificates(or update-ca-trust)

```bash
git clone https://github.com/dyrnq/docker-ca-certificates.git

## base image alpine
cd docker-ca-certificates/alpine
docker build -t ca:alpine
docker run -d --name -p 443:443 ca-alpine ca:alpine

## base image centos
cd docker-ca-certificates/centos
docker build -t ca:centos
docker run -d --name -p 443:443 ca-centos ca:centos

## base image debian
cd docker-ca-certificates/buster
docker build -t ca:buster
docker run -d --name -p 443:443 ca-buster ca:buster

## base image ubuntu
cd docker-ca-certificates/ubuntu
docker build -t ca:ubuntu
docker run -d --name -p 443:443 ca-ubuntu ca:ubuntu
```

## ref

- [nginx: Linux packages](http://nginx.org/en/linux_packages.html)