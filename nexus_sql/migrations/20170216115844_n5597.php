<?php

class N5597 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('reservation_event_suspend',
		                      ['id' => false,
		                       'primary_key' => ['active_reservation_event_id', 'suspended_reservation_event_id']]);
		$table->addNexusForeignKeyColumn('active_reservation_event_id',
		                                 ['delete' => 'CASCADE'], 'reservation_event');
		$table->addNexusForeignKeyColumn('suspended_reservation_event_id',
		                                 ['delete' => 'CASCADE'], 'reservation_event');
		$table->create();
	}
}
