<?php

class N5910 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('event_shift');
		$table->addColumn('base_cash_amount', 'integer',
		                  ['limit' => 10, 'null' => true, 'after' => 'event_id']);
		$table->update();
	}
}
