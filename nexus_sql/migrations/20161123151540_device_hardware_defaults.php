<?php

use Phinx\Migration\AbstractMigration;

class DeviceHardwareDefaults extends AbstractMigration
{
	public function up()
	{
		$this->execute(" UPDATE device_hardware SET device_identifier = NULL WHERE NOT device_identifier ");
		$this->execute(" UPDATE device_hardware SET hardware_model = NULL WHERE NOT hardware_model ");
		$this->execute(" UPDATE device_hardware SET local_ip = NULL WHERE NOT local_ip ");
		$this->execute(" UPDATE device_hardware SET remote_ip = NULL WHERE NOT remote_ip ");

		$table = $this->table('device_hardware');

		$table->changeColumn('device_identifier', 'string',
		                     ['default' => null, 'null' => true, 'limit' => 100, 'after' => 'device_hardware_id']);
		$table->changeColumn('hardware_model', 'string',
		                     ['default' => null, 'null' => true, 'limit' => 100, 'after' => 'device_identifier']);
		$table->changeColumn('local_ip', 'string',
		                     ['default' => null, 'null' => true, 'limit' => 50, 'after' => 'rtunnel_port']);
		$table->changeColumn('remote_ip', 'string',
		                     ['default' => null, 'null' => true, 'limit' => 50, 'after' => 'local_ip']);
		$table->update();
	}

	public function down()
	{
		$table = $this->table('device_hardware');

		$table->changeColumn('device_identifier', 'string',
		                     ['default' => '', 'null' => true, 'limit' => 100, 'after'   => 'device_hardware_id']);
		$table->changeColumn('hardware_model', 'string',
		                     ['default' => '', 'null' => true, 'limit' => 100, 'after' => 'device_identifier']);
		$table->changeColumn('local_ip', 'string',
		                     ['default' => '', 'null' => true, 'limit' => 50, 'after' => 'rtunnel_port']);
		$table->changeColumn('remote_ip', 'string',
		                     ['default' => '', 'null' => true, 'limit' => 50, 'after' => 'local_ip']);
		$table->update();
	}
}
