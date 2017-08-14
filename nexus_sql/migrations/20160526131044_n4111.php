<?php

use Phinx\Migration\AbstractMigration;

class N4111 extends AbstractMigration
{
	public function up()
	{
		$test = $this->table('device_type');
		$test->changeColumn('package_url', 'text', ['null' => true]);
		$test->changeColumn('executable', 'string', ['null' => true, 'limit' => 100]);
		$test->changeColumn('config', 'text', ['null' => true]);

	}

	public function down()
	{
		$test = $this->table('device_type');
		$test->changeColumn('package_url', 'text', ['null' => false]);
		$test->changeColumn('executable', 'string', ['null' => false, 'limit' => 100]);
		$test->changeColumn('config', 'text', ['null' => false]);
	}
}
