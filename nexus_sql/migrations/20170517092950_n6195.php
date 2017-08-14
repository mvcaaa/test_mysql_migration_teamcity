<?php

class N6195 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('message');
	    $table->addColumn('creation_timestamp', 'timestamp', [
	    		'null' => false,
	    		'default' => NDT_ZERO_DATETIME,
	    		'after' => 'message_status_id'
	    ]);
	    $table->update();
    }
}
