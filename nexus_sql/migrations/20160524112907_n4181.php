<?php

use Phinx\Migration\AbstractMigration;

class N4181 extends AbstractMigration
{
    public function change()
    {
        $table = $this->table('access_right_template');
        $options = ['default' => null, 'null' => true, 'length' => 50];
        $table->addColumn('external_id', 'string', $options)->update();
    }
}
