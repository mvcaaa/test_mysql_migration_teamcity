#!/bin/bash

export COMPOSER_HOME="$(pwd)/lib"
printenv

cd ${COMPOSER_HOME}
composer --dev --verbose --optimize-autoloader install
vendor/bin/phinx --version

mysql --host="${MYSQL_HOST}" --user="${MYSQL_USER}" --password="${MYSQL_ROOT_PASSWORD}" -e exit 2>/dev/null
dbstatus=`echo $?`

if [ $dbstatus -ne 0 ]; then
  echo "MySQL connection problems, exiting"
  exit $dbstatus
fi
