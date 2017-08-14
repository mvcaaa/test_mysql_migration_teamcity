<?php

use Phinx\Migration\AbstractMigration;

class N5417 extends AbstractMigration
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
		$table = $this->table('region', ['id' => false, 'primary_key' => 'region_id']);
		$table->addColumn('region_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);
		$table->addColumn('name', 'string', ['limit' => 100, 'null' => false]);
		$table->addColumn('is_active', 'boolean', ['default' => 1, 'null' => false, 'signed' => false]);
		$table->create();

		$table = $this->table('location');
		$options = ['signed' => false, 'limit' => 10, 'null' => true, 'after' => 'organization_id'];
		$table->addColumn('region_id', 'integer', $options);
		$table->addForeignKey('region_id', 'region', 'region_id', [
			'constraint' => 'FK_location_region',
			'update'     => 'CASCADE',
			'delete'     => 'SET NULL'
		]);
		$table->update();
	}
}
