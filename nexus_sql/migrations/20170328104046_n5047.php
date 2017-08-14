<?php

class N5047 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('reservation');
		$table->addColumn('is_reservation_permanent', 'boolean',
		                  ['default' => 0, 'null' => false, 'signed' => false, 'after' => 'is_paid']);
		$table->update();

		$table = $this->table('service_at_area');
		$table->addColumn('is_reservation_permanent', 'boolean',
		                  ['default' => 0, 'null' => false, 'signed' => false, 'after' => 'is_product_not_required']);
		$table->update();
	}
}
