apk add --update postgresql-client

export PGUSER="${POSTGRES_USER}"
echo "PGUSER: $POSTGRES_USER"
export PGPASSWORD="${POSTGRES_PASSWORD}"
echo "PGPASSWORD: $POSTGRES_PASSWORD"
export gvp_pg_db_server="${gvp_pg_db_server}"
echo "GVP Posgres DB Server: $gvp_pg_db_server"
export gvp_cm_pg_db_name="${gvp_cm_pg_db_name}"
echo "GVP Posgres DB NAME: $gvp_cm_pg_db_name"
export gvp_cm_pg_db_user="${gvp_cm_pg_db_user}"
echo "GVP Posgres DB USER: $gvp_cm_pg_db_user"
export gvp_cm_pg_db_password="${gvp_cm_pg_db_password}"

echo Check gvp database
psql -U $POSTGRES_USER -h ${gvp_pg_db_server} -tc "SELECT 1 FROM pg_database WHERE datname = '${gvp_cm_pg_db_name}'"| grep -q 1 || \
    psql -U $POSTGRES_USER -h ${gvp_pg_db_server} -c "CREATE DATABASE \"${gvp_cm_pg_db_name}\""

echo Check $gvp_cm_pg_db_user user
psql -U $POSTGRES_USER -h ${gvp_pg_db_server} -tc "SELECT 1 FROM pg_user WHERE usename = '$gvp_cm_pg_db_user'"| grep -q 1
if [ $? -ne 0 ]; then
    psql -U $POSTGRES_USER -h ${gvp_pg_db_server} -c "CREATE USER $gvp_cm_pg_db_user WITH SUPERUSER LOGIN CONNECTION LIMIT -1 PASSWORD '$gvp_cm_pg_db_password'"
fi
psql -U $POSTGRES_USER -h ${gvp_pg_db_server} -c "GRANT all privileges on database \"${gvp_cm_pg_db_name}\" to $gvp_cm_pg_db_user"