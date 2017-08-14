<?php

class N5785 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('reservation_event_slot', ['nexus_primary' => true]);
	    $table->addNexusForeignKeyColumn('reservation_event_id', ['null' => false, 'delete' => 'CASCADE']);
	    $table->addColumn('time_start', 'datetime', ['null' => false]);
	    $table->addColumn('time_end', 'datetime', ['null' => false]);
	    $table->create();
    }
}
