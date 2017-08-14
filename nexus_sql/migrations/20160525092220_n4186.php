<?php

use Phinx\Migration\AbstractMigration;

class N4186 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('subscription');
		$options = ['default' => null, 'null' => true];
		$table->addColumn('current_invoice_period_start', 'date', $options);
		$table->addColumn('current_invoice_period_end', 'date', $options);
		$table->update();
	}
}
