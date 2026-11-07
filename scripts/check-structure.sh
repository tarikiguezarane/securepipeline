#!/usr/bin/env bash
# Repository structure test: fails if a mandatory directory or file of the platform
# layout is missing, or if Terraform state / plaintext secrets are tracked by Git.
set -euo pipefail

cd "$(dirname "$0")/.."

required=(
  terraform
  clusters
  apps
  charts
  policies
  .github/workflows
  docs
  .gitignore
  LICENSE
  README.md
  ROADMAP.md
  JOURNAL.md
)

status=0
for path in "${required[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "MISSING: $path"
    status=1
  fi
done

# Terraform state and private keys contain secrets and must never be versioned.
forbidden=$(git ls-files | grep -E '(\.tfstate(\..*)?$|\.tfvars$|\.pem$|\.key$|(^|/)\.env$)' || true)
if [[ -n "$forbidden" ]]; then
  echo "FORBIDDEN files tracked by Git:"
  echo "$forbidden"
  status=1
fi

if ! grep -q "MIT License" LICENSE; then
  echo "INVALID: LICENSE is not MIT"
  status=1
fi

if [[ $status -eq 0 ]]; then
  echo "Repository structure OK"
fi
exit $status
