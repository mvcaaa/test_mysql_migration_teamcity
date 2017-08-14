#!/bin/bash

export COMPOSER_HOME="$(pwd)/lib"
# printenv

cd ${COMPOSER_HOME}
composer --dev --optimize-autoloader install
vendor/bin/phinx --version

vendor/bin/phinx status -c phinx_template.php -e docker

mysql --host="${PHINX_NEXUS_DB_HOST}" --user="${PHINX_NEXUS_DB_USER}" --password="${PHINX_NEXUS_DB_PASSWORD}" -e exit 2>/dev/null
dbstatus=`echo $?`

if [ $dbstatus -ne 0 ]; then
  echo "MySQL connection problems, exiting"
  exit $dbstatus
fi
