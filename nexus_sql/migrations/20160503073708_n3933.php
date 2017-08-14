<?php

use Phinx\Migration\AbstractMigration;

class N3933 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('parameter_description');
		$table->addColumn('is_custom', 'boolean', [
				'default' => false,
				'null'    => false,
				'signed'  => false,
		]);

		$table->update();
	}
}
