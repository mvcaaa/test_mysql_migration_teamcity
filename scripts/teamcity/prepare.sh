#/bin/bash

export COMPOSER_HOME = "$(PWD)/lib"

printenv
php -v
composer --version

cd $(COMPOSER_HOME)
composer --dev --verbose --optimize-autoloader install
