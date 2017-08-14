<?php

use Phinx\Migration\AbstractMigration;

class N3243 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('parameter');
		$table->addColumn('is_active', 'boolean', [
				'default' => 1,
				'null'    => false,
				'signed'  => false,
		]);

		$table->update();
	}
}
