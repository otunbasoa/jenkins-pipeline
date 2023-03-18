#!/bin/bash

# Make the script executable
chmod +x deploy-certbot.sh

# Install Certbot and the Nginx plugin
kubectl run certbot --image=certbot/certbot:v1.23.0 --restart=Never -- /bin/sh -c "apk add --no-cache nginx; apk add --no-cache certbot; apk add --no-cache certbot-nginx"

# Obtain a certificate from Let's Encrypt using Certbot and the Nginx plugin
kubectl run certbot --image=certbot/certbot:v1.23.0 --restart=Never -- /bin/sh -c "certbot --nginx -d anjorin.me -d www.anjorin.me -d sockapp.anjorin.me -d grafana.anjorin.me -d prometheus.anjorin.me -d myprofile.anjorin.me"

# Restart Nginx to apply the changes
kubectl exec -it certbot -- /bin/sh -c "nginx -s reload"
