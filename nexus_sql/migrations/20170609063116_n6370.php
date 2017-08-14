<?php

class N6370 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('contact_type', ['nexus_primary' => true]);
		$table->addNameColumn();
		$table->create();

		$table = $this->table('contact');
		$table->addNexusForeignKeyColumn('contact_type_id', ['null' => true, 'after' => 'contact_id']);
		$table->update();
	}
}
