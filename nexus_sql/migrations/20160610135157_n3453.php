<?php

use Phinx\Migration\AbstractMigration;

class N3453 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('service_at_area_resource');
		$table->addColumn('max_events', 'integer', ['default' => 1, 'null' => true]);
		$table->addColumn('max_capacity', 'integer', ['default' => null, 'null' => true]);
		$table->update();
	}
}
