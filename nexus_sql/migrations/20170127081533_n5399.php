<?php

use Phinx\Migration\AbstractMigration;
use Phinx\Db\Adapter\MysqlAdapter;

class N5399 extends AbstractMigration
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
		$table = $this->table('reservation_type', ['id' => false, 'primary_key' => 'reservation_type_id']);
		$table->addColumn('reservation_type_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);
		$table->addColumn('name', 'string', ['limit' => 100, 'null' => false]);
		$table->addColumn('priority', 'integer',
		                  ['signed' => false, 'default' => 10, 'null' => false, 'limit' => MysqlAdapter::INT_TINY]);
		$table->addColumn('is_active', 'boolean', ['default' => 1, 'null' => false, 'signed' => false]);
		$table->create();

		$table = $this->table('reservation_event');
		$options = ['signed' => false, 'limit' => 10, 'null' => true, 'after' => 'service_at_area_id'];
		$table->addColumn('reservation_type_id', 'integer', $options);
		$table->addForeignKey('reservation_type_id', 'reservation_type', 'reservation_type_id', [
			'constraint' => 'FK_reservation_event_reservation_type',
			'update'     => 'CASCADE',
			'delete'     => 'SET NULL'
		]);
		$table->update();
	}
}
