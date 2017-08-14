<?php

use Phinx\Migration\AbstractMigration;

class N4996 extends AbstractMigration
{
	public function up()
	{
		$test = $this->table('fare_product');
		$test->changeColumn('name', 'string', ['null' => false, 'limit' => 100]);

	}

	public function down()
	{
		$test = $this->table('fare_product');
		$test->changeColumn('name', 'string', ['null' => false, 'limit' => 50]);
	}
}
