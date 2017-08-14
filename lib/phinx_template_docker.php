<?php
return [
		'environments' => [
				'dev.mvc' => [
						'adapter'    => 'mysql',
						'host'       => '%%PHINX_NEXUS_DB_HOST%%',
						'name'       => '%%PHINX_NEXUS_DB_NAME%%',
						'user'       => '%%PHINX_NEXUS_DB_USER%%',
						'pass'       => '%%PHINX_NEXUS_DB_PASSWORD%%',
						'port'       => '3306',
						'charset'    => 'utf8',
						'collection' => 'utf8_general_ci',
				]
		]
];
