#!/bin/bash
# Backup de PartKeepr con marca de tiempo en el nombre del volcado SQL

set -euo pipefail

# === Configuración ===
CONTAINER_NAME="partkeepr_partkeepr_1"       # Contenedor de la app PartKeepr
DATABASE_CONTAINER_NAME="partkeepr_database_1" # Contenedor de la base de datos (MariaDB/MySQL)
BACKUP_PATH="$HOME/Escritorio/partkeepr_backup" # Carpeta donde se guardarán los backups

# === Preparación ===
TIMESTAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
DEST_DIR="${BACKUP_PATH}/${TIMESTAMP}"
SQL_FILE="${DEST_DIR}/backup_part_${TIMESTAMP}.sql"

mkdir -p "${DEST_DIR}"

# Comprobaciones rápidas
if ! docker inspect "${CONTAINER_NAME}" >/dev/null 2>&1; then
  echo "No existe el contenedor de aplicación: ${CONTAINER_NAME}"
  exit 1
fi

if ! docker inspect "${DATABASE_CONTAINER_NAME}" >/dev/null 2>&1; then
  echo "No existe el contenedor de base de datos: ${DATABASE_CONTAINER_NAME}"
  exit 1
fi

# La BD debe estar corriendo para poder ejecutar mysqldump
if [ "$(docker inspect -f '{{.State.Running}}' "${DATABASE_CONTAINER_NAME}")" != "true" ]; then
  echo "El contenedor de base de datos no está en ejecución: ${DATABASE_CONTAINER_NAME}"
  exit 1
fi

# === Copia de ficheros de datos ===
echo "Copiando carpeta 'data' desde el contenedor de PartKeepr…"
docker cp "${CONTAINER_NAME}:/var/www/html/data" "${DEST_DIR}/data"
echo "Carpeta 'data' copiada en: ${DEST_DIR}/data"

# === Volcado de base de datos ===
echo "Generando volcado de la base de datos…"
docker exec "${DATABASE_CONTAINER_NAME}" \
  mysqldump -u partkeepr -p'partkeepr' partkeepr > "${SQL_FILE}"
echo "Volcado SQL guardado en: ${SQL_FILE}"

# (Opcional) Comprimir el volcado para ahorrar espacio
# gzip -9 "${SQL_FILE}" && echo "Volcado comprimido en: ${SQL_FILE}.gz"

echo "Respaldo completo en: ${DEST_DIR}"

