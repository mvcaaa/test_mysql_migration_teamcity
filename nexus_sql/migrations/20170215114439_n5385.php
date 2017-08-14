<?php

class N5385 extends NexusMigration
{
	public function up()
	{
		if ($this->hasTable('reservation_application_period')) {
			$this->dropTable('reservation_application_period_resource');
			$this->dropTable('reservation_application');
			$this->dropTable('reservation_application_period');
			$this->query("
				DELETE
				FROM phinx_log
				WHERE migration_name LIKE '%N3854%'
				");
		}
	}
}
