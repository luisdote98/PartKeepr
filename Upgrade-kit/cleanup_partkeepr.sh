#!/usr/bin/env bash
set -e

echo " Deteniendo y eliminando contenedores ‘partkeepr’ y ‘partmanager’…"
docker ps -a --filter "name=partkeepr"       --format "{{.ID}}" | xargs -r docker rm -f
docker ps -a --filter "name=partmanager"     --format "{{.ID}}" | xargs -r docker rm -f

echo " Borrando volúmenes ‘partkeepr’ y ‘partmanager’…"
docker volume ls --filter "name=partkeepr"   --format "{{.Name}}" | xargs -r docker volume rm
docker volume ls --filter "name=partmanager" --format "{{.Name}}" | xargs -r docker volume rm

echo " Eliminando redes ‘partkeepr’ y ‘partmanager’…"
docker network ls --filter "name=partkeepr"  --format "{{.Name}}" | xargs -r docker network rm
docker network ls --filter "name=partmanager" --format "{{.Name}}" | xargs -r docker network rm

echo " Quitando imágenes relacionadas…"
docker images --format "{{.Repository}}:{{.Tag}}" \
  | grep -E "mhubig/partkeepr|partkeepr/development|mariadb:10\.0" \
  | xargs -r docker rmi -f

echo " Limpieza completada. Comprueba con:"
echo "   docker ps -a"
echo "   docker volume ls"
echo "   docker network ls"
echo "   docker images | grep -E 'partkeepr|partmanager|mariadb:10\\.0'"

