<?php

class N6666 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('service');
		$table->addColumn('max_reservations', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);
		$table->update();
	}
}
