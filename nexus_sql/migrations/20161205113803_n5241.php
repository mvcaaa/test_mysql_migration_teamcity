<?php

use Phinx\Migration\AbstractMigration;

class N5241 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('token');
		$table->addColumn('printed_name', 'string', [
				'default' => null,
				'null'    => true,
				'limit'   => 45
		]);
		$table->update();
	}
}
