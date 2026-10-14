#!/usr/bin/env sh
# Constitution article V and ADR-001: this repository never owns the schema.
# Fails if any tracked file other than this script contains table DDL.
set -eu

cd "$(dirname "$0")/.."

matches=$(git grep -n -i -E 'create[[:space:]]+table|alter[[:space:]]+table' -- . ':!scripts/check-no-ddl.sh' || true)

if [ -n "$matches" ]; then
  echo "DDL found in infra, it belongs to the api migrations:"
  echo "$matches"
  exit 1
fi

echo "OK: infra contains no table DDL."
