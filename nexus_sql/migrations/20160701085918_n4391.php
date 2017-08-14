<?php

use Phinx\Migration\AbstractMigration;

class N4391 extends AbstractMigration
{
	public function change()
	{
		$fk_options = [
				'constraint' => 'FK_event_transfer_reservation_event',
				'update' => 'CASCADE',
				'delete' => 'CASCADE'
		];

		$this->table('event_transfer_reservation')
				->addForeignKey('event_id', 'event', 'event_id', $fk_options)
				->update();
	}
}
