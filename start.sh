#!/bin/bash
source code.conf
echo "Deteniendo los contenedores si estan en ejecucion..."
DB_BUILD_USER=$DB_BUILD_USER DB_BUILD_NAME=$DB_BUILD_NAME DB_BUILD_PASS=$DB_BUILD_PASS USER_ID=$USER_ID docker-compose down
echo "Borrando datos de la base de datos..."
sudo rm -rf database
echo "Entorno Inventarios"
echo "Creacion de carpetas necesarias del contenedor..."
if [ -f workspace/ ]; then
    echo "Las Carpetas ya fueron creadas..."
else
    mkdir -p workspace/python
    mkdir -p workspace/angular
fi
mkdir -p database
#echo "Construyendo Contendor..."
DB_BUILD_USER=$DB_BUILD_USER DB_BUILD_NAME=$DB_BUILD_NAME DB_BUILD_PASS=$DB_BUILD_PASS USER_ID=$USER_ID docker-compose build
echo "ejecutando contenedor..."
DB_BUILD_USER=$DB_BUILD_USER DB_BUILD_NAME=$DB_BUILD_NAME DB_BUILD_PASS=$DB_BUILD_PASS USER_ID=$USER_ID docker-compose up -d
until DB_BUILD_USER=$DB_BUILD_USER DB_BUILD_NAME=$DB_BUILD_NAME DB_BUILD_PASS=$DB_BUILD_PASS USER_ID=$USER_ID docker-compose exec postgresdb sh -c 'psql inventarios_db crud_user' ; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
DB_BUILD_USER=$DB_BUILD_USER DB_BUILD_NAME=$DB_BUILD_NAME DB_BUILD_PASS=$DB_BUILD_PASS USER_ID=$USER_ID docker-compose exec postgresdb sh -c 'psql -h localhost -p 5432 -U crud_user -d inventarios_db -f "/bkup/bkup.bak"'

#for f in sql/*.sql;do
#    DB_BUILD_USER=$DB_BUILD_USER DB_BUILD_NAME=$DB_BUILD_NAME DB_BUILD_PASS=$DB_BUILD_PASS docker-compose exec postgresdb psql -U crud_user -d inventarios_db -a -f $f
#done
echo "ejecutando contenedor..."
echo "El contenedor se esta ejecutando en segundo plano..."
