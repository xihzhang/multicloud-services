export PGUSER="${postgres_user}"
export PGPASSWORD="${postgres_password}"

apk add --update postgresql-client

echo Check gauth database
psql -h ${postgres_host} -tc "SELECT 1 FROM pg_database WHERE datname = 'pulse'"| grep -q 1 || \
    psql -h ${postgres_host} -c "CREATE DATABASE \"pulse\""