#!/usr/bin/env bash

mysql --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" -e "DROP DATABASE nexus_base; CREATE DATABASE nexus_base;"
mysql --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" nexus_base < nexus_sql/nexus_base.sql

mysqladmin --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" create "${PHINX_NEXUS_DB_NAME}"

cd "$(pwd)/lib"

vendor/bin/phinx migrate -c phinx_template.php