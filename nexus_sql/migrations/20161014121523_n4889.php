<?php

use Phinx\Migration\AbstractMigration;

class N4889 extends AbstractMigration
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
	public function up()
	{
		$table = $this->table('locker');
		$table->dropForeignKey('location_id');
		$table->removeIndexByName('location_number');
		$table->changeColumn('number', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);
		$table->addForeignKey('location_id', 'location', 'location_id', [
			'constraint' => 'FK_locker_location',
			'update'     => 'CASCADE',
			'delete'     => 'RESTRICT'
		]);
		$table->update();
	}

	public function down()
	{
		$table = $this->table('locker');
		$table->dropForeignKey('location_id');
		$table->removeIndexByName('FK_locker_location');
		$table->addIndex(['location_id', 'number'], ['name' => 'location_number', 'unique' => true]);
		$table->changeColumn('number', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
		$table->addForeignKey('location_id', 'location', 'location_id', [
			'constraint' => 'FK_locker_location',
			'update'     => 'CASCADE',
			'delete'     => 'RESTRICT'
		]);
		$table->update();
	}
}
