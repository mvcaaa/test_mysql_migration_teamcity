<?php

use Phinx\Migration\AbstractMigration;

class N4970 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('locker');
		$table->addColumn('is_open_once', 'boolean', ['default' => false,
		                                              'signed'  => false,
		                                              'null'    => false,
		                                              'after'   => 'is_locked']);
		$table->update();

	}
}
