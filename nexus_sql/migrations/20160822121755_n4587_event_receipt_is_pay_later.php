<?php

use Phinx\Migration\AbstractMigration;

class N4587EventReceiptIsPayLater extends AbstractMigration
{
    public function change()
    {
		$table = $this->table('event_receipt');
		$table->addColumn('is_pay_later', 'boolean', [
				'default' => null,
				'null'    => true,
				'signed'  => false,
		]);

		$table->update();
    }
}
