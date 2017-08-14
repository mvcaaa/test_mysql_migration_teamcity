<?php

use Phinx\Migration\AbstractMigration;

class N4916 extends AbstractMigration
{
	/**
	 * Change Method.
	 *
	 * Write your reversible migrations using this method.
	 *
	 * More information on writing migrations is available here:
	 * http://docs.phinx.org/en/latest/migrations.html#the-abstractmigration-class
	 *
	 * The following commands can be used in this method and Phinx will
	 * automatically reverse them when rolling back:
	 *
	 *    createTable
	 *    renameTable
	 *    addColumn
	 *    renameColumn
	 *    addIndex
	 *    addForeignKey
	 *
	 * Remember to call "create()" or "update()" and NOT "save()" when working
	 * with the Table class.
	 */
	public function change()
	{
		$table = $this->table('device_hardware');

		$table->addColumn('device_identifier', 'string', ['default' => '', 'null' => true, 'limit' => 100,
		                                               'after'   => 'device_hardware_id']);
		$table->addColumn('hardware_model', 'string', ['default' => '', 'null' => true, 'limit' => 100,
		                                               'after'   => 'device_identifier']);
		$table->addColumn('local_ip', 'string', ['default' => '', 'null' => true, 'limit' => 50,
		                                         'after'   => 'rtunnel_port']);
		$table->addColumn('remote_ip', 'string', ['default' => '', 'null' => true, 'limit' => 50,
		                                          'after'   => 'local_ip']);
		$table->addColumn('is_active', 'boolean', ['default' => true, 'signed' => false, 'null' => false]);
		$table->update();

		$table = $this->table('device_config');
		$table->addColumn('software_name', 'string', ['default' => '', 'null' => true, 'limit' => 100]);
		$table->addColumn('version', 'string', ['default' => '', 'null' => true, 'limit' => 100]);
		$table->addColumn('desired_version', 'string', ['default' => '', 'null' => true, 'limit' => 100]);
		$table->addColumn('is_active', 'boolean', ['default' => true, 'signed' => false, 'null' => false]);
		$table->update();
	}
}
