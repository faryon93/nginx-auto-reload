#!/bin/ash
NGINX_CONFIG_DIR="/etc/nginx/conf.d"

{
   echo "watching $NGINX_CONFIG_DIR for configuration changes"

    while true
    do
    inotifywait --exclude .swp -e create -e modify -e delete -e move $NGINX_CONFIG_DIR
    echo "nginx configuration $NGINX_CONFIG_DIR changed"
    
    nginx -t
    if [ $? -eq 0 ]; then
        echo "nginx configuration test successfull: executing \"nginx -s reload\""
        nginx -s reload
    else
        echo "nginx configuration test failed: aborting"
    fi
    done
} &
