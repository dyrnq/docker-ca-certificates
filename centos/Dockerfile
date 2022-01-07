FROM centos:centos7

ENV nginxversion="1.20.2-1" \
    os="centos" \
    elversion="7"

RUN \
    ARCH="$(arch)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         javaArch="aarch64"; \
         nginxArch="aarch64"; \
         ;; \
       armhf|armv7l) \
         javaArch="arm"; \
         nginxArch="armhf"; \
         ;; \
       ppc64el|ppc64le) \
         javaArch="ppc64le"; \
         nginxArch="ppc64el"; \
         ;; \
       amd64|x86_64) \
         javaArch="x64"; \
         nginxArch="x86_64"; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    yum install yum-utils openssl curl ca-certificates sed wget psmisc which gcc perl-core pcre-devel make zlib-devel -y && \
    yum clean all && \
    wget http://nginx.org/packages/$os/$elversion/$nginxArch/RPMS/nginx-$nginxversion.el$elversion.ngx.$nginxArch.rpm && \
    rpm -iv nginx-$nginxversion.el$elversion.ngx.$nginxArch.rpm && \
    mkdir -p /usr/local/src/openssl && \
    curl -fsSL https://www.openssl.org/source/openssl-1.1.1m.tar.gz | tar xvz --strip-components=1 -C /usr/local/src/openssl && \
    cd /usr/local/src/openssl && \
    ./config --prefix=/usr/local --openssldir=/etc/ssl --libdir=lib && \
    make && \
    make install && \
    ls -l /usr/local && \
    ln -s -f /usr/local/bin/openssl /usr/bin/openssl && \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/openssl.conf && \
    ldconfig -v

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]