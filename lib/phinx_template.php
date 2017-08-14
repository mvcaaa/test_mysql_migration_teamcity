<?php

require_once(__DIR__ . '/../nexus_app/constants/constants.php');
//require_once(__DIR__ . '/Helpers/_lib_dates.php');
require_once(__DIR__ . '/../nexus_sql/migrations/NexusMigration.php');

define('NDT_ZERO_DATETIME', '0000-00-00 00:00:00');

$tmp = [];
$out = [
		'paths'        => [
				'migrations' => '%%PHINX_CONFIG_DIR%%/../nexus_sql/migrations'
		],
		'environments' => [
				'default_migration_table' => 'phinx_log',
				'production'              => [
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

foreach (glob("lib/phinx_template_*.php") as $filename) {
	$tmp = include $filename;
	$out['environments'] = array_merge($out['environments'], $tmp['environments']);
}

return $out;
