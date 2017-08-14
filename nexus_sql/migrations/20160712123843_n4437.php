<?php

use Phinx\Migration\AbstractMigration;

class N4437 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('reservation_event_group');

		$table->addColumn('sale_group_id', 'integer', ['signed'  => false,
		                                               'limit'   => 10,
		                                               'default' => null,
		                                               'null'    => true,
		                                               'after'   => 'reservation_group_id']);
		$table->addForeignKey('sale_group_id', 'sale_group', 'sale_group_id',
		                      ['constraint' => 'FK_reservation_event_group_sale_group',
		                       'update'     => 'CASCADE',
		                       'delete'     => 'SET NULL']);

		$table->update();
	}
}
