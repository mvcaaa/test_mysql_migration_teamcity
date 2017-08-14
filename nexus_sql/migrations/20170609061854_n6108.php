<?php

class N6108 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('module_location',
		                      ['id' => false, 'primary_key' => ['module_id', 'location_id']]);
		$table->addNexusForeignKeyColumn('module_id', ['delete' => 'CASCADE']);
		$table->addNexusForeignKeyColumn('location_id', ['delete' => 'CASCADE']);
		$table->create();

		$table = $this->table('module');
		$table->addColumn('image_url', 'string', ['null' => false, 'length' => 100]);
		$table->addColumn('activation_label', 'string', ['null' => false, 'length' => 100]);
		$table->update();
	}
}