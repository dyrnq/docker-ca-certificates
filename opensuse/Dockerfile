FROM opensuse/leap:15.4

RUN \
    zypper refresh && \
    zypper install --no-confirm curl ca-certificates p11-kit-tools gpg2 && \
    zypper addrepo --gpgcheck --type yum --refresh --check 'http://nginx.org/packages/sles/$releasever_major' nginx-stable && \
    curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key && \
    rpmkeys --import /tmp/nginx_signing.key && \
    zypper install --no-confirm nginx


COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]