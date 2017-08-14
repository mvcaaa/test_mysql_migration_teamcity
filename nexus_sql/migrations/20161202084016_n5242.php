<?php

use Phinx\Migration\AbstractMigration;

class N5242 extends AbstractMigration
{
    public function change()
    {
	    $table = $this->table('delivery_type');
	    $table->addColumn('is_active', 'boolean', ['default' => false, 'null' => false, 'signed' => false])->update();
    }
}
