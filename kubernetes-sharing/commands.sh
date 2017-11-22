# Aliases were used
# Check these here: https://github.com/ntk148v/kubectl-aliases

# Label & Selector
k create -f staging-nginx.yaml
kd pod nginx-staging
k run nginx-prod --image=nginx --replicas=2 --port=80 \
    --labels="environment=production,project=pilot,tier=frontend"
kgpo
kgpo -l "project=pilot,environment=production"

# Secrets
k create secret generic db-user-pass --from-file=./username.txt \
    --from-file=./password.txt
kg secrets
kd secrets/db-user-pass

# Deployments & ReplicaSet
k create -f nginx-deployment.yaml
kgpo
kgdep

# Jobs
k create -f countdown-job.yaml
kd jobs countdown-demo
pods=$(kg pods --show-all --selector=job-name=countdown-demo --output=jsonpath={.items..metadata.name})
echo $pods
kl $pods

# Services
k run nginx-pod-demo --image=nginx --port=80 --restart="Never" \
--labels="app=nginx"
k expose pod nginx-pod-demo --port=8001 --target-port=80 \
    --name="service-pod-demo"
kgsvc service-pod-demo

k expose deployment nginx-deployment-demo --name="service-deployment-demo" \
    --external-ip="<IP>"
kgsvc service-deployment-demo
kdsvc service-deployment-demo

# Volumes
k create -f emptydir-volume.yaml
kgpo
# docker inspect <container_id>
kdpo ubuntu-demo

# Ingress
k create ing -f single-svc-ingress.yaml
kg ing

