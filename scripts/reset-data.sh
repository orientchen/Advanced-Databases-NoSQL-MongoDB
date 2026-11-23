#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
docker compose up -d
until docker compose exec -T mongo mongosh --quiet --eval 'db.adminCommand({ping:1}).ok' 2>/dev/null | grep -q 1; do sleep 2; done
docker compose exec -T mongo mongosh --quiet --eval 'db.getSiblingDB("campus_store").dropDatabase()'
docker compose exec -T mongo mongoimport --db campus_store --collection customers --file /dev/stdin --jsonArray < data/customers.json
docker compose exec -T mongo mongoimport --db campus_store --collection orders --file /dev/stdin --jsonArray < data/orders.json
printf '\nDataset reset. Start shell: docker compose exec mongo mongosh campus_store\n'
