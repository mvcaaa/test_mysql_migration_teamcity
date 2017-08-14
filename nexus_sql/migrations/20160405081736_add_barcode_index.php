<?php

use Phinx\Migration\AbstractMigration;

class AddBarcodeIndex extends AbstractMigration
{
    public function change()
    {
		$table = $this->table('inventory_item');
		$table->addIndex('barcode');
		$table->update();
    }
}
