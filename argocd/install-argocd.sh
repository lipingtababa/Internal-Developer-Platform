#!/bin/bash

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# use LoadBalancer instead of NodePort for public access
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
