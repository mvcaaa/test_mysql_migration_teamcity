<?php

use Phinx\Migration\AbstractMigration;

class N4916DropColumns extends AbstractMigration
{
	/**
	 * This was made separately since dropping columns cannot be automatically reversed
	 */
	public function up()
	{
		$table = $this->table('device_config');
		$table->removeColumn('original_device_id');
		$table->dropForeignKey('device_type_id');
		$table->removeColumn('device_type_id');
		$table->removeColumn('software_version');
		$table->removeColumn('name');
		$table->removeColumn('config_version');
		$table->removeColumn('package_url');
		$table->removeColumn('executable');
		$table->removeColumn('config');
		$table->removeColumn('certificate_url');
		$table->update();
	}

	public function down()
	{
		$table = $this->table('device_config');
		$table->addColumn('original_device_id', 'integer', ['signed' => false, 'null' => true, 'limit' => 10,
		                                                    'after'  => 'system_id']);
		$table->addColumn('device_type_id', 'integer', ['signed' => false, 'null' => true, 'limit' => 10,
		                                                'after'  => 'original_device_id']);;
		$table->addForeignKey('device_type_id', 'device_type', 'device_type_id', [
			'constraint' => 'FK_device_config_type',
			'update' => 'CASCADE',
			'delete' => 'SET NULL'
		]);
		$table->addColumn('software_version', 'string', ['null' => true, 'limit' => 45, 'after' => 'device_type_id']);
		$table->addColumn('name', 'string', ['null' => true, 'limit' => 45, 'after' => 'device_id']);
		$table->addColumn('config_version', 'string', ['null' => true, 'limit' => 45, 'after' => 'name']);
		$table->addColumn('package_url', 'text', ['null' => true, 'limit' => 'TEXT_REGULAR', 'after' => 'config_version']);
		$table->addColumn('executable', 'string', ['null' => true, 'limit' => 100, 'after' => 'package_url']);
		$table->addColumn('config', 'text', ['null' => true, 'limit' => 'TEXT_REGULAR', 'after' => 'executable']);
		$table->addColumn('certificate_url', 'text', ['null' => true, 'limit' => 'TEXT_REGULAR', 'after' => 'config']);
		$table->update();
	}
}
