#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# DB Version: 14
# OS Type: linux
# DB Type: web
# Total Memory (RAM): 1 GB
# CPUs num: 1
# Data Storage: hdd

# max_connections = 200
# shared_buffers = 256MB
# effective_cache_size = 768MB
# maintenance_work_mem = 64MB
# checkpoint_completion_target = 0.9
# wal_buffers = 7864kB
# default_statistics_target = 100
# random_page_cost = 4
# effective_io_concurrency = 2
# work_mem = 655kB
# min_wal_size = 1GB
# max_wal_size = 4GB

psql -c "ALTER SYSTEM SET max_connections = '200';"
psql -c "ALTER SYSTEM SET shared_buffers = '256MB';"
psql -c "ALTER SYSTEM SET effective_cache_size = '768MB';"
psql -c "ALTER SYSTEM SET maintenance_work_mem = '64MB';"
psql -c "ALTER SYSTEM SET checkpoint_completion_target = '0.9';"
psql -c "ALTER SYSTEM SET wal_buffers = '7864kB';"
psql -c "ALTER SYSTEM SET default_statistics_target = '100';"
psql -c "ALTER SYSTEM SET random_page_cost = '4';"
psql -c "ALTER SYSTEM SET effective_io_concurrency = '2';"
psql -c "ALTER SYSTEM SET work_mem = '655kB';"
psql -c "ALTER SYSTEM SET min_wal_size = '1GB';"
psql -c "ALTER SYSTEM SET max_wal_size = '4GB';"

# restore database if dump file exists
if [ -f /opt/backups/restore.dump ]; then
  echo "Restoring backup..."
  pg_restore -d gis --clean --if-exists /opt/backups/restore.dump
fi