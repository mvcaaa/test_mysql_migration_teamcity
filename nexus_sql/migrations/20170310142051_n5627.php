<?php

class N5627 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('service_type', ['nexus_primary' => true]);
		$table->addNameColumn();
		$table->addIsActiveColumn(0);

		if (!$table->exists())
			$table->insert([
				['service_type_id' => 1, 'name' => 'Customer Service', 'is_active' => 1]
			]);

		$table->create();

		$table = $this->table('service');
		$table->addNexusForeignKeyColumn('service_type_id',
		                                 ['null' => false, 'default' => 1]);
		$table->update();
	}
}
