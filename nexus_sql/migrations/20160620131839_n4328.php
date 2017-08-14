<?php

use Phinx\Migration\AbstractMigration;

class N4328 extends AbstractMigration
{
    public function change()
    {
        $table = $this->table('external_api');
        $options = ['default' => null, 'null' => true, 'limit' => 255, 'after' => 'api_url'];
        $table->addColumn('auth_url', 'string', $options);
        $table->update();
    }
}
