<?php

use Phinx\Migration\AbstractMigration;

class N4680 extends AbstractMigration
{
    public function change()
    {
	    $table = $this->table('external_api');
	    $options = ['default' => null, 'null' => true, 'signed' => false, 'limit' => 2];
	    $table->addColumn('port', 'integer', $options)->update();
    }
}
