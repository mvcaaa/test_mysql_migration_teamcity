#/bin/bash

printenv

export $COMPOSER_HOME = "$(PWD)/lib"

cd $COMPOSER_HOME
composer --dev --verbose --optimize-autoloader install
