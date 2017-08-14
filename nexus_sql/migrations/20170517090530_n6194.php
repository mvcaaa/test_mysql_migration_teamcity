<?php

class N6194 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('message_object_link', [
	    		'id' => false,
		      'primary_key' => ['message_id', 'object_id', 'object_name']
	    ]);
	    $table->addNexusForeignKeyColumn('message_id', ['null' => false, 'delete' => 'CASCADE']);
	    $table->addColumn('object_id', 'integer', ['null' => false, 'signed' => false, 'limit' => 10]);
	    $table->addColumn('object_name', 'string', ['null' => false, 'length' => 100]);
	    $table->create();
    }
}
