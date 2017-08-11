#!/bin/bash

export COMPOSER_HOME="$(pwd)/lib"
printenv

cd $(COMPOSER_HOME)
composer --dev --verbose --optimize-autoloader install
