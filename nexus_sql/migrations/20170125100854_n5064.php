<?php

use Phinx\Migration\AbstractMigration;

class N5064 extends AbstractMigration
{
    public function change()
    {
	    $table = $this->table('data_for_object', ['id' => false, 'primary_key' => 'data_for_object_id']);
	    $table->addColumn('data_for_object_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);
	    $table->addColumn('object_name', 'string', ['limit' => 100, 'null' => false]);
	    $table->addColumn('object_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addColumn('field_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addColumn('value', 'string', ['null' => true, 'limit' => 100]);
	    $table->create();
    }
}