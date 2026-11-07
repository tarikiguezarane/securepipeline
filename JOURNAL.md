# Journal de progression

Une entrée par jour, la plus récente en haut.

## 2026-11-07 – Jour 1 : structure du dépôt

**Fait**
- Arborescence `terraform/`, `clusters/kind/`, `apps/`, `charts/`, `policies/`, `.github/workflows/`, `docs/`, `scripts/`, avec un README par dossier qui indique le jour où il sera rempli.
- Licence MIT, `.gitignore` orienté IaC (états Terraform, `*.tfvars`, kubeconfig, clés privées, `.env`).
- README : objectifs, architecture cible (Mermaid), arborescence, stack. `docs/architecture.md` : schéma complet et matrice « étape → contrôle → outil ».
- Test `scripts/check-structure.sh` (dossiers obligatoires, aucun `.tfstate`/`.tfvars`/clé/`.env` versionné, licence MIT) et CI : test + shellcheck + yamllint.

**Choix techniques**
- Séparation `clusters/` (point d'entrée GitOps par cluster) / `apps/` (Applications ArgoCD) / `charts/` (Helm) : c'est le découpage classique « app of apps » qui permet d'ajouter un cluster sans dupliquer les applications.
- `.tfstate` ignoré et vérifié en CI : un état Terraform contient souvent des secrets en clair.
- `permissions: contents: read` sur le workflow : moindre privilège du `GITHUB_TOKEN` dès le début.

**À retenir pour un entretien**
- GitOps = Git comme source de vérité + agent qui *tire* l'état voulu (ArgoCD) au lieu d'une CI qui *pousse* dans le cluster : pas d'identifiants du cluster dans la CI, dérive détectée et corrigée.
- Défense en profondeur sur la supply chain : scan (Trivy) → SBOM (Syft) → signature (Cosign) → vérification à l'admission (Kyverno).

**Limites connues**
- Aucune ressource déployable pour l'instant : Terraform arrive au jour 2.
- Tests et lint validés localement ; la CI GitHub reste à observer.

## 2026-11-07 – Jour 0 : lancement

- Création du dépôt, de la feuille de route sur 30 jours (`ROADMAP.md`) et des instructions de travail quotidien (`CLAUDE.md`).
- Prochaine étape : Jour 1.
