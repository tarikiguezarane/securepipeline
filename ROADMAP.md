# Feuille de route – SecurePipeline (30 jours)

**Profil visé : Cloud / DevOps / DevSecOps.** Plateforme GitOps et DevSecOps qui déploie VulnTrack
(`tarikiguezarane/vulntrack`) sur Kubernetes, avec la sécurité intégrée à chaque étape : code, images, supply chain,
cluster, exécution et observabilité.

Stack : Terraform, kind (option OVHcloud / Scaleway), ArgoCD, Helm, GitHub Actions, Semgrep, Trivy, Gitleaks,
Syft, Cosign, Kyverno, NetworkPolicies, OpenTelemetry, Prometheus, Grafana, Loki.

Règle : chaque jour, faire la première étape non cochée, puis la cocher. Une étape = un incrément qui marche et qui est testé.
Tant que les images de VulnTrack ne sont pas publiées sur GHCR (prévues vers le jour 14 de VulnTrack),
utiliser l'application de démonstration du jour 5.

## Semaine 1 – Infrastructure as Code et GitOps
- [x] Jour 1 – Structure : `terraform/`, `clusters/`, `apps/`, `charts/`, `policies/`, `.github/workflows/`, `docs/`, licence MIT, README (architecture cible).
- [ ] Jour 2 – Terraform : cluster kind via provider, modules, variables, `terraform fmt` et `validate` en CI.
- [ ] Jour 3 – Terraform : namespaces et ingress-nginx via le provider Helm.
- [ ] Jour 4 – Installation d'ArgoCD par Terraform + bootstrap « app of apps ».
- [ ] Jour 5 – Application de démonstration minimale (API conteneurisée) pour valider la chaîne de bout en bout.
- [ ] Jour 6 – Chart Helm de l'application de démo + Application ArgoCD synchronisée depuis Git.
- [ ] Jour 7 – GitHub Actions : build et publication de l'image de démo sur GHCR.

## Semaine 2 – Sécurité de la supply chain
- [ ] Jour 8 – Semgrep (SAST) dans la CI, résultats SARIF dans GitHub Code Scanning.
- [ ] Jour 9 – Gitleaks (secrets) en CI + configuration pre-commit.
- [ ] Jour 10 – Trivy : scan des images et de l'IaC (Terraform, Helm), échec sur vulnérabilité critique.
- [ ] Jour 11 – Syft : génération du SBOM des images, publié en artefact.
- [ ] Jour 12 – Cosign keyless (OIDC GitHub) : signature des images et attestation du SBOM.
- [ ] Jour 13 – Workflow réutilisable (`workflow_call`) regroupant toute la chaîne sécurité, utilisable par VulnTrack.
- [ ] Jour 14 – Dependabot ou Renovate, et documentation des règles de protection de branche.

## Semaine 3 – Déploiement de VulnTrack et sécurité du cluster
- [ ] Jour 15 – Kyverno installé via ArgoCD.
- [ ] Jour 16 – Politiques Kyverno : vérification des signatures Cosign, interdiction des conteneurs privilégiés, non-root obligatoire, limites de ressources.
- [ ] Jour 17 – NetworkPolicies : refus par défaut + flux autorisés explicitement.
- [ ] Jour 18 – Charts Helm pour VulnTrack : backend, frontend, PostgreSQL, Keycloak.
- [ ] Jour 19 – Applications ArgoCD pour VulnTrack depuis les images GHCR, environnements dev et prod.
- [ ] Jour 20 – Gestion des secrets : Sealed Secrets ou SOPS.
- [ ] Jour 21 – Observabilité : kube-prometheus-stack via ArgoCD.

## Semaine 4 – Observabilité, cloud et finition
- [ ] Jour 22 – Logs : Loki + collecteur (Alloy ou Promtail).
- [ ] Jour 23 – OpenTelemetry Collector + traces (Tempo) des services VulnTrack.
- [ ] Jour 24 – Tableaux de bord Grafana et règles d'alerte versionnés dans Git.
- [ ] Jour 25 – CI de bout en bout : cluster kind dans GitHub Actions, bootstrap, vérification que tout ArgoCD est « Healthy ».
- [ ] Jour 26 – Option cloud : module Terraform Scaleway Kapsule ou OVHcloud MKS (plan seulement, documenté, sans apply).
- [ ] Jour 27 – Détection à l'exécution : Falco avec quelques règles adaptées.
- [ ] Jour 28 – Modèle de menace et correspondance des contrôles (SLSA, CIS Kubernetes).
- [ ] Jour 29 – Documentation d'architecture (Mermaid) + README final avec badges.
- [ ] Jour 30 – Release v1.0.0 : CHANGELOG, tag Git, bilan dans le journal.
