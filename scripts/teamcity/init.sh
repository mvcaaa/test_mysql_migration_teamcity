#!/usr/bin/env bash

mysql --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" -e "DROP DATABASE nexus_base;"
mysql --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" -e "CREATE DATABASE nexus_base;"
mysql --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" nexus_base < nexus_sql/nexus_base.sql

mysqladmin --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" create "${PHINX_NEXUS_DB_NAME}"

cd "$(pwd)/lib"

vendor/bin/phinx migrate -c phinx_template.php

mysqldiff --server1="${PHINX_NEXUS_DB_USER}":"${PHINX_NEXUS_DB_PASSWORD}"@"${PHINX_NEXUS_DB_HOST}" "${PHINX_NEXUS_DB_NAME}":nexus_base --force --skip-table-options --compact

vendor/bin/phinx rollback -c phinx_template.php -t 0