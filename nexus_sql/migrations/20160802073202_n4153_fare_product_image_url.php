<?php

use Phinx\Migration\AbstractMigration;

class N4153FareProductImageUrl extends AbstractMigration
{
    public function change()
    {
        $table = $this->table('fare_product');
        $table->addColumn('image_url', 'text', ['default' => null, 'null' => true]);
        $table->update();
    }
}
