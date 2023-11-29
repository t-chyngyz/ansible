server {
        listen 80;
        listen [::]:80;

        server_name {{ domainname }} www.{{ domainname }};
        return 301 https://{{ domainname }}$request_uri;
}

server {
        listen 443 ssl;
        server_name {{ domainname }} www.{{ domainname }};
        ssl_certificate {{ cert_dir }}certificate.pem;
        ssl_certificate_key {{ cert_dir }}certificate.key;
        root {{ document_root }};
        index index.html index.htm;
        location / {
                        try_files $uri $uri/ =404;
        }
}