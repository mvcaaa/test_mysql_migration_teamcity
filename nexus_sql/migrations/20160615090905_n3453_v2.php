<?php

use Phinx\Migration\AbstractMigration;

class N3453V2 extends AbstractMigration
{
	public function up()
	{
		$table = $this->table('resource');
		$table->addColumn('max_events', 'integer', ['default' => 1, 'null' => true]);
		$table->addColumn('max_capacity', 'integer', ['default' => null, 'null' => true]);
		$table->addColumn('max_events_starting', 'integer', ['default' => null, 'null' => true]);
		$table->update();

		$table2 = $this->table('service_at_area_resource');
		$table2->removeColumn('max_events');
		$table2->removeColumn('max_capacity');
		$table2->update();
	}

	public function down()
	{
		$table = $this->table('resource');
		$table->removeColumn('max_events');
		$table->removeColumn('max_capacity');
		$table->removeColumn('max_events_starting');
		$table->update();

		$table2 = $this->table('service_at_area_resource');
		$table2->addColumn('max_events', 'integer', ['default' => 1, 'null' => true]);
		$table2->addColumn('max_capacity', 'integer', ['default' => null, 'null' => true]);
		$table2->update();
	}
}
