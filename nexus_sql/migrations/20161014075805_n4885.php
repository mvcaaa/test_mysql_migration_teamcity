 <?php

use Phinx\Migration\AbstractMigration;

class N4885 extends AbstractMigration
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
		$table = $this->table('locker_group', ['id'          => false,
		                                     'primary_key' => 'locker_group_id']);
		$table->addColumn('locker_group_id', 'integer',
		                  ['signed' => false, 'limit' => 10, 'identity' => true]);

		$table->addColumn('name', 'string', ['null' => false, 'limit' => 45]);

		$table->addColumn('location_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
		$table->addForeignKey('location_id', 'location', 'location_id', [
			'constraint' => 'FK_locker_group_location',
			'update' => 'CASCADE',
			'delete' => 'RESTRICT'
		]);

		$table->addColumn('is_active', 'boolean', ['default' => true, 'signed' => false, 'null' => false]);
		$table->create();

		// ========================

		$table = $this->table('locker');
		$table->addColumn('relay_device_hardware_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);
		$table->addForeignKey('relay_device_hardware_id', 'device_hardware', 'device_hardware_id', [
			'constraint' => 'FK_locker_relay_device_hardware',
			'update' => 'CASCADE',
			'delete' => 'RESTRICT'
		]);
		$table->addColumn('relay_number', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);

		$table->addColumn('input_device_hardware_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);
		$table->addForeignKey('input_device_hardware_id', 'device_hardware', 'device_hardware_id', [
			'constraint' => 'FK_locker_input_device_hardware',
			'update' => 'CASCADE',
			'delete' => 'RESTRICT'
		]);
		$table->addColumn('input_number', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);

		$table->addColumn('locker_group_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);
		$table->addForeignKey('locker_group_id', 'locker_group', 'locker_group_id', [
			'constraint' => 'FK_locker_locker_group',
			'update' => 'CASCADE',
			'delete' => 'RESTRICT'
		]);

		$table->addColumn('error', 'text', ['default' => '', 'null' => true, 'limit' => 'TEXT_REGULAR']);

		$table->update();

		// ========================

		$table = $this->table('device_locker_group', ['id'          => false,
		                                       'primary_key' => ['device_id', 'locker_group_id']]);

		$table->addColumn('device_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
		$table->addForeignKey('device_id', 'device', 'device_id', [
			'constraint' => 'FK_device_locker_group_device',
			'update' => 'CASCADE',
			'delete' => 'RESTRICT'
		]);

		$table->addColumn('locker_group_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
		$table->addForeignKey('locker_group_id', 'locker_group', 'locker_group_id', [
			'constraint' => 'FK_device_locker_group_locker_group',
			'update' => 'CASCADE',
			'delete' => 'RESTRICT'
		]);

		$table->create();

	}
}
