<?php

use Phinx\Migration\AbstractMigration;
use Phinx\Db\Adapter\MysqlAdapter;

class N5581 extends AbstractMigration
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
		$table = $this->table('age_group', ['id' => false, 'primary_key' => 'age_group_id']);
		$table->addColumn('age_group_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);
		$table->addColumn('name', 'string', ['limit' => 50, 'null' => false]);
		$table->addColumn('min_age', 'integer',
		                  ['signed' => false, 'default' => 0, 'null' => false, 'limit' => MysqlAdapter::INT_TINY]);
		$table->addColumn('max_age', 'integer',
		                  ['signed' => false, 'default' => 255, 'null' => false, 'limit' => MysqlAdapter::INT_TINY]);
		$table->addColumn('is_active', 'boolean', ['default' => 1, 'null' => false, 'signed' => false]);
		$table->create();

		$table = $this->table('fare_product');
		$table->addColumn('age_group_id', 'integer',
		                  ['signed' => false, 'limit' => 10, 'null' => true, 'after' => 'customer_group_id']);
		$table->addForeignKey('age_group_id', 'age_group', 'age_group_id', [
			'constraint' => 'FK_fare_product_age_group',
			'update'     => 'CASCADE',
			'delete'     => 'SET NULL'
		]);
		$table->update();

		$table = $this->table('user');
		$table->addColumn('age', 'integer',
		                  ['signed' => false, 'default' => null, 'null' => true, 'after' => 'date_of_birth',
		                   'limit' => MysqlAdapter::INT_TINY]);
		$table->update();
	}
}
