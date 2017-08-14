<?php

use Phinx\Migration\AbstractMigration;

class N4336 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('service_at_area');
		$table->addColumn('is_product_not_required', 'boolean', [
				'default' => null,
				'null'    => true,
				'signed'  => false,
		]);

		$table->update();
	}
}
