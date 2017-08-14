<?php

class Initial extends NexusMigration
{
	public function up()
	{
		$this->execute(file_get_contents(__DIR__.'/../nexus_base_initial_migration.sql'));
	}
}
