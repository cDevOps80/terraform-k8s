# kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sleep 20
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

sleep 10
kubectl get secrets argocd-initial-admin-secret -o=jsonpath='{.data.password}' -n argocd  | base64 -d ; echo ""


# argocd app create guestbook --repo https://github.com/cDevOps80/ArgoCD-Roboshop.git --path roboshop-helm --values ../dev-values/frontend.yaml --dest-namespace default -dest-server https://kubernetes.default.svc