#!/usr/bin/env bash

mkdir -p /opt/tls/

pushd /opt/tls/ || exit 1
openssl version

openssl dhparam -out dhparam.pem 2048

# If you want a non password protected key just remove the -des3 option
# openssl genrsa -des3 -out rootCA.key 4096
# openssl genrsa -aes256 -out rootCA.key 4096

openssl genrsa -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 36600 -subj "/CN=rootCA" -reqexts v3_req -extensions v3_ca -out rootCA.crt


openssl genrsa -out server.key 2048
openssl req -new -key server.key -subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=localhost/emailAddress=server@vivo.com" -out server.csr


cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = hello.com
DNS.2 = demo.local
DNS.2 = localhost
IP.1 = 127.0.0.1
IP.2 = 192.168.1.163
EOF

openssl x509 -req -sha512 -days 36600 -extfile v3.ext -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -in server.csr -out server.crt


cp rootCA.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust force-enable
/usr/bin/update-ca-trust

popd || exit 1

cat > /etc/nginx/conf.d/default.conf <<'EOF'
server {
    charset utf-8;
    listen 443 http2 ssl;
    server_name  hello.com;
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    ssl_prefer_server_ciphers off;
    ssl_dhparam /opt/tls/dhparam.pem;
    ssl_session_timeout  1d;
    ssl_session_cache shared:SSL:10m;
    ssl_session_tickets off;
    ssl_buffer_size 4k;
    ssl_certificate  /opt/tls/server.crt;
    ssl_certificate_key  /opt/tls/server.key;
}
EOF

nohup nginx -c /etc/nginx/nginx.conf &
sleep 5s

openssl x509 -in /opt/tls/rootCA.crt -text -noout
openssl x509 -in /opt/tls/server.crt -text -noout

curl --header "host:hello.com" https://127.0.0.1

exec "$@"