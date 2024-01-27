server {
        listen 80;
        listen [::]:80;

        server_name {{ domainname }} www.{{ domainname }};
        root {{ document_root }};
        index index.html index.htm;
        location / {
                        try_files $uri $uri/ =404;
        }
}