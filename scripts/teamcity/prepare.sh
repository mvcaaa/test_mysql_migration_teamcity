#/bin/bash

COMPOSER_HOME = "$(PWD)/lib"

printenv

cd $COMPOSER_HOME
composer --dev --verbose --optimize-autoloader install
