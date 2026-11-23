#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
docker compose up -d
printf '\nMongoDB container starting. Run: bash scripts/reset-data.sh\n'
