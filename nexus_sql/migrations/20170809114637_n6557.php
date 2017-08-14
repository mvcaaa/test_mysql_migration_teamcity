<?php

class N6557 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('agreement');
		$table->addColumn('is_vat_zero', 'boolean',
		                  ['signed'  => false,
		                   'null'    => false,
		                   'default' => false,
		                   'after'   => 'is_resource_reservation_allowed']);
		$table->update();
	}
}
