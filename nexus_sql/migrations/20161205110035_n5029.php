<?php

use Phinx\Migration\AbstractMigration;

class N5029 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('tag');
		$table->addColumn('description', 'text', ['default' => null, 'null' => true]);
		$table->update();

		$table = $this->table('tag_group');
		$table->addColumn('description', 'text', ['default' => null, 'null' => true]);
		$table->update();

	}
}
