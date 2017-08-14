<?php

use Phinx\Migration\AbstractMigration;

class N3857 extends AbstractMigration
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
		$test = $this->table('test');
		$test->changeColumn('decimal', 'decimal', ['scale' => '3', 'precision' => '9', 'default' => '0']);

	}

	public function down()
	{
		$test = $this->table('test');
		$test->changeColumn('decimal', 'decimal', ['scale' => '3', 'precision' => '9', 'default' => null]);
	}
}
