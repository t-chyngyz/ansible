server {
    listen 80;
    server_name flask.{{ domainname }};

    location / {
        include proxy_params;
      	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP	$remote_addr;
      	proxy_set_header Host $http_host;
      	proxy_redirect off;
        proxy_buffers 8 24k;
        proxy_buffer_size 4k;
        proxy_pass http://unix:{{ gunicorn_socket }};
    }
}