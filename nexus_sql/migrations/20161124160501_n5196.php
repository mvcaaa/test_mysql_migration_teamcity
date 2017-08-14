<?php

use Phinx\Migration\AbstractMigration;

class N5196 extends AbstractMigration
{
    public function change()
    {
	    $table = $this->table('reservation');
	    $options = ['default' => false, 'null' => false, 'signed' => false];
	    $table->addColumn('is_notify', 'boolean', $options)->update();
    }
}
