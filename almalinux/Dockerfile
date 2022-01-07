FROM almalinux:8.5

ENV nginxversion="1.20.2-1" \
    os="centos" \
    elversion="8"

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
    yum install yum-utils openssl curl ca-certificates sed wget psmisc procps-ng which -y && \
    yum clean all && \
    wget http://nginx.org/packages/$os/$elversion/$nginxArch/RPMS/nginx-$nginxversion.el$elversion.ngx.$nginxArch.rpm && \
    rpm -iv nginx-$nginxversion.el$elversion.ngx.$nginxArch.rpm

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]