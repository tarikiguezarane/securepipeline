# clusters/

GitOps entry points, one folder per cluster. ArgoCD watches `clusters/<name>/` through an
"app of apps" root Application (Day 4) that references everything under `apps/`.
