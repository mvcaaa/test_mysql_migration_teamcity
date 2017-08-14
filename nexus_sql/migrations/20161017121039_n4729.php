<?php

use Phinx\Migration\AbstractMigration;

class N4729 extends AbstractMigration
{
    public function change()
    {
	    $table = $this->table('event_offline', ['id' => false, 'primary_key' => 'event_id']);
	    $table->addColumn('event_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addColumn('offline_event_key', 'string', ['limit' => 100, 'null' => true, 'default' => null]);
	    $table->addColumn('arrival_timestamp', 'datetime', ['null' => true, 'default' => null]);

	    $table->addForeignKey(
			    'event_id',
			    'event',
			    'event_id',
			    ['constraint' => 'FK_event_offline_event', 'update' => 'CASCADE', 'delete' => 'CASCADE']
	    );

	    $table->create();
    }
}