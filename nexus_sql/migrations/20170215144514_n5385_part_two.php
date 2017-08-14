<?php

class N5385PartTwo extends NexusMigration
{
	public function change()
	{
		$table = $this->table('reservation_application_status', ['nexus_primary' => true]);
		$table->addNameColumn();
		$table->addIsActiveColumn();
		$table->create();

		$table = $this->table('reservation_application', ['nexus_primary' => true]);
		$table->addNexusForeignKeyColumn('reservation_application_status_id');

		$table->addColumn('creation_timestamp', 'datetime', ['null' => false]);
		$table->addColumn('status_timestamp', 'datetime', ['null' => false]);
		$table->addIsActiveColumn();

		$table->addNexusForeignKeyColumn('service_id', ['null' => true]);
		$table->addNexusForeignKeyColumn('user_id', ['null' => true]);
		$table->addNexusForeignKeyColumn('organization_id', ['null' => true]);

		$table->addColumn('date_start', 'date', ['null' => false]);
		$table->addColumn('date_end', 'date', ['null' => false]);

		$table->addColumn('time_slots', 'text', ['null' => false]);
		$table->addColumn('data', 'text', ['null' => true, 'default' => null]);

		$table->create();

		$table = $this->table('reservation_application_resource',
		                      ['id' => false, 'primary_key' => ['reservation_application_id', 'resource_id']]);
		$table->addNexusForeignKeyColumn('reservation_application_id', ['delete' => 'CASCADE']);
		$table->addNexusForeignKeyColumn('resource_id', ['delete' => 'CASCADE']);
		$table->create();
	}
}
