<?php

use Phinx\Migration\AbstractMigration;
use Phinx\Db\Adapter\MysqlAdapter;

class N5494 extends AbstractMigration
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
		$table = $this->table('season_type', ['id' => false, 'primary_key' => 'season_type_id']);
		$table->addColumn('season_type_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);
		$table->addColumn('name', 'string', ['limit' => 100, 'null' => false]);
		$table->addColumn('is_active', 'boolean', ['default' => 1, 'null' => false, 'signed' => false]);
		$table->create();

		$table = $this->table('season', ['id' => false, 'primary_key' => 'season_id']);
		$table->addColumn('season_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);
		$table->addColumn('name', 'string', ['limit' => 100, 'null' => false]);
		$table->addColumn('season_type_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
		$table->addForeignKey('season_type_id', 'season_type', 'season_type_id', [
			'constraint' => 'FK_season_season_type',
			'update'     => 'CASCADE',
			'delete'     => 'CASCADE'
		]);
		$table->addColumn('date_start', 'date', ['null' => false]);
		$table->addColumn('date_end', 'date', ['null' => false]);
		$table->addColumn('is_active', 'boolean', ['default' => 1, 'null' => false, 'signed' => false]);
		$table->create();

		$table = $this->table('reservation_event_group');
		$table->addColumn('season_id', 'integer',
		                  ['signed' => false, 'limit' => 10, 'null' => true, 'after' => 'public_visibility_end']);
		$table->addForeignKey('season_id', 'season', 'season_id', [
			'constraint' => 'FK_reservation_event_group_season',
			'update'     => 'CASCADE',
			'delete'     => 'SET NULL'
		]);
		$table->update();
	}
}
