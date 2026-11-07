# Target architecture

```mermaid
flowchart TB
    subgraph gh[GitHub]
        code[VulnTrack source] --> ci[GitHub Actions<br/>reusable security workflow]
        ci -- Semgrep / Gitleaks / Trivy --> scan[Code Scanning SARIF]
        ci -- build + Syft SBOM + Cosign sign --> ghcr[(GHCR images)]
        repo[securepipeline repo<br/>Terraform, Helm, ArgoCD apps, policies]
    end

    tf[Terraform] --> k8s
    repo -- GitOps pull --> argo

    subgraph k8s[Kubernetes cluster kind / Kapsule / MKS]
        argo[ArgoCD app of apps]
        kyv[Kyverno<br/>verify signatures, non-root, limits]
        np[NetworkPolicies<br/>default deny]
        vt[VulnTrack<br/>frontend, backend, PostgreSQL, Keycloak]
        obs[Prometheus, Grafana, Loki, Tempo, OTel Collector]
        falco[Falco runtime detection]
        argo --> vt
        argo --> kyv
        argo --> obs
    end

    ghcr -- signed images --> kyv --> vt
```

## Security controls per stage

| Stage | Control | Tool |
|-------|---------|------|
| Code | Static analysis, secret detection | Semgrep, Gitleaks, pre-commit |
| Dependencies | Automated updates | Dependabot / Renovate |
| Build | Image and IaC vulnerability scan, SBOM | Trivy, Syft |
| Supply chain | Keyless signing and SBOM attestation | Cosign (GitHub OIDC) |
| Deployment | Git as single source of truth | ArgoCD |
| Admission | Signature verification, pod hardening | Kyverno |
| Network | Default-deny east-west traffic | NetworkPolicies |
| Secrets | Encrypted secrets in Git | Sealed Secrets / SOPS |
| Runtime | Suspicious behaviour detection | Falco |
| Observability | Metrics, logs, traces, alerts | Prometheus, Loki, Tempo, Grafana |
