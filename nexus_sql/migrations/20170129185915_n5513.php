<?php

use Phinx\Migration\AbstractMigration;

class N5513 extends AbstractMigration
{
    public function change()
    {
	    $table = $this->table('message');
	    $table->addColumn('message_status_id', 'integer', [
	    		'signed' => false,
		      'limit' => 10,
		      'null' => true,
		      'after' => 'message_type_id'
	    ]);
	    $table->addColumn('last_status_timestamp', 'datetime', [
	    		'null' => true,
		      'default' => null,
		      'after' => 'message_status_id'
	    ]);
	    $table->addForeignKey('message_status_id', 'message_status', 'message_status_id', [
			    'constraint' => 'FK_message_message_status_id',
			    'update' => 'CASCADE',
			    'delete' => 'RESTRICT'
	    ]);
	    $table->update();
    }
}
