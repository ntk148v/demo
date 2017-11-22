# Aliases were used
# Check these here: https://github.com/ntk148v/kubectl-aliases

# Label & Selector
k create -f staging-nginx.yaml
kd pod nginx-staging
k run nginx-prod --image=nginx --replicas=2 --port=80 \
    --labels="environment=production,project=pilot,tier=frontend"
kgpo
kgpo -l "project=pilot,environment=production"



