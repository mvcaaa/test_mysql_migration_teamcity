<?php

use Phinx\Migration\AbstractMigration;

class N4297 extends AbstractMigration
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
		$table = $this->table('service_at_area');
		$table->addColumn('minimum_time_slots_number', 'integer', ['default' => 0,
		                                                           'null'    => false,
		                                                           'signed'  => false,
		                                                           'limit'   => 10,
		                                                           'after'   => 'time_slot_duration']);
		$table->update();
	}
}
