# ca-certificates

## Quick reference

This is a demo for `How to add CA root certification (self-signed)` use openssl and update-ca-certificates(or update-ca-trust)

```bash
git clone https://github.com/dyrnq/docker-ca-certificates.git

## base image alpine
cd docker-ca-certificates/alpine
docker build -t ca:alpine .
docker run -d --name ca-alpine ca:alpine
docker exec -it ca-alpine bash -c "curl --header \"host:hello.com\" https://127.0.0.1"

## base image centos
cd docker-ca-certificates/centos
docker build -t ca:centos .
docker run -d --name ca-centos ca:centos
docker exec -it ca-centos bash -c "curl --header \"host:hello.com\" https://127.0.0.1"

## base image debian
cd docker-ca-certificates/buster
docker build -t ca:buster .
docker run -d --name ca-buster ca:buster
docker exec -it ca-buster bash -c "curl --header \"host:hello.com\" https://127.0.0.1"

## base image ubuntu
cd docker-ca-certificates/ubuntu
docker build -t ca:ubuntu .
docker run -d --name ca-ubuntu ca:ubuntu
docker exec -it ca-ubuntu bash -c "curl --header \"host:hello.com\" https://127.0.0.1"

## base image almalinux
cd docker-ca-certificates/almalinux
docker build -t ca:almalinux .
docker run -d --name ca-almalinux ca:almalinux
docker exec -it ca-almalinux bash -c "curl --header \"host:hello.com\" https://127.0.0.1"
```

## ref

- [nginx: Linux packages](http://nginx.org/en/linux_packages.html)