#!/usr/bin/env bash

mysql --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" create "${PHINX_NEXUS_DB_NAME}"

cd "$(pwd)/lib"

vendor/bin/phinx status -c phinx_template.php