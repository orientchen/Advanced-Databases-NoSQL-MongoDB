# Advanced Databases — MongoDB Hands-on Lab

A GitHub Codespaces classroom lab for CSCI 480 / CIS 680. MongoDB runs in a local Docker container. No Atlas account, credit card, or local MongoDB installation is required.

## Start

1. Open this repository in GitHub Codespaces (2-core machine is sufficient).
2. Wait for `postCreateCommand` to finish.
3. In the terminal run:

   ```bash
   bash scripts/reset-data.sh
   docker compose exec mongo mongosh campus_store
   ```

4. At the `campus_store>` prompt try:

   ```javascript
   show collections
   db.customers.find()
   db.orders.find({status: "pending"})
   ```

**Important:** Enter MongoDB queries at the `mongosh` prompt, not the Linux shell. Type `exit` to leave `mongosh`.

## Files

- `exercises/lab.md` — student lab
- `instructor/solutions.md` — instructor answer key (remove or keep private before distributing to students)
- `data/*.json` — small fictional classroom dataset
- `scripts/reset-data.sh` — resets all practice data; **deletes** the `campus_store` database

## Persistence and safety

MongoDB data is stored in a Docker volume and normally survives container restarts within the same Codespace. A deleted Codespace loses its local data. All data is fictional. Port 27017 is intended for local use only; **do not make it public**. This lab intentionally has no database authentication and is not for production use.

## Useful commands

```bash
docker compose ps
docker compose exec mongo mongosh campus_store
docker compose logs --tail=30 mongo
docker compose down                  # stop and remove container, preserve volume
bash scripts/reset-data.sh           # restore original dataset; removes student changes
```

For Cengage Chapter 14: document database model, importing documents, `find()` queries, and basic CRUD. Advanced distributed features such as sharding and replica sets are discussed conceptually, not configured in this single-node classroom lab.
