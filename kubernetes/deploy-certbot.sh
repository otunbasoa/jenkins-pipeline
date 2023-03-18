#!/bin/bash

POD_NAME="certbot"
NAMESPACE="default"

# Install Certbot and Nginx in a new pod
kubectl run "${POD_NAME}" --image=certbot/certbot:v1.23.0 --restart=Never -- /bin/sh -c "apk add --no-cache nginx; apk add --no-cache certbot; apk add --no-cache certbot-nginx"

# Get the name of the nginx container in the pod
CONTAINER_NAME=$(kubectl get pods "${POD_NAME}" -n "${NAMESPACE}" -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | grep nginx)

# Run certbot in the nginx container
kubectl exec "${POD_NAME}" -n "${NAMESPACE}" -c "${CONTAINER_NAME}" -- certbot --nginx -d anjorin.me -d www.anjorin.me -d sockapp.anjorin.me -d grafana.anjorin.me -d prometheus.anjorin.me -d myprofile.anjorin.me

# Restart Nginx to apply the changes
kubectl exec "${POD_NAME}" -n "${NAMESPACE}" -c "${CONTAINER_NAME}" -- nginx -s reload
