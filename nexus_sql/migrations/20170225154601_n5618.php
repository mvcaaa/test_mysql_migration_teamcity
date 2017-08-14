<?php

use Phinx\Migration\AbstractMigration;

class N5618 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('receipt_session',
			    ['id' => false, 'identity' => false, 'primary_key' => 'receipt_event_id']);
	    $table->addNexusForeignKeyColumn('receipt_event_id', ['delete' => 'CASCADE'], 'event');
	    $table->addColumn('session_json', 'text', ['null' => false]);
	    $table->create();
    }
}
