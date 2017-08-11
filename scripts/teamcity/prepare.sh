#/bin/bash

COMPOSER_HOME = "$(pwd)/lib"
export COMPOSER_HOME = $COMPOSER_HOME
printenv

cd $COMPOSER_HOME
composer --dev --verbose --optimize-autoloader install
