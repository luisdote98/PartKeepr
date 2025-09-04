#!/bin/bash
# PartKeepr backup with timestamp in the SQL dump filename

set -euo pipefail

# === Configuration ===
CONTAINER_NAME="partkeepr_partkeepr_1"         # PartKeepr application container
DATABASE_CONTAINER_NAME="partkeepr_database_1" # Database container (MariaDB/MySQL)
BACKUP_PATH="$HOME/Desktop/partkeepr_backup"   # Folder where backups will be saved

# === Preparation ===
TIMESTAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
DEST_DIR="${BACKUP_PATH}/${TIMESTAMP}"
SQL_FILE="${DEST_DIR}/backup_part_${TIMESTAMP}.sql"

mkdir -p "${DEST_DIR}"

# Quick checks
if ! docker inspect "${CONTAINER_NAME}" >/dev/null 2>&1; then
  echo "Application container does not exist: ${CONTAINER_NAME}"
  exit 1
fi

if ! docker inspect "${DATABASE_CONTAINER_NAME}" >/dev/null 2>&1; then
  echo "Database container does not exist: ${DATABASE_CONTAINER_NAME}"
  exit 1
fi

# The database must be running in order to execute mysqldump
if [ "$(docker inspect -f '{{.State.Running}}' "${DATABASE_CONTAINER_NAME}")" != "true" ]; then
  echo "Database container is not running: ${DATABASE_CONTAINER_NAME}"
  exit 1
fi

# === Copy data files ===
echo "Copying 'data' folder from the PartKeepr container…"
docker cp "${CONTAINER_NAME}:/var/www/html/data" "${DEST_DIR}/data"
echo "'data' folder copied to: ${DEST_DIR}/data"

# === Database dump ===
echo "Generating database dump…"
docker exec "${DATABASE_CONTAINER_NAME}" \
  mysqldump -u partkeepr -p'partkeepr' partkeepr > "${SQL_FILE}"
echo "SQL dump saved in: ${SQL_FILE}"

# (Optional) Compress the dump to save space
# gzip -9 "${SQL_FILE}" && echo "Dump compressed to: ${SQL_FILE}.gz"

echo "Full backup stored in: ${DEST_DIR}"
