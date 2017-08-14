<?php

use Phinx\Migration\AbstractMigration;

class N3875 extends AbstractMigration
{
	public function change()
	{
		$table = $this->table('event_duration', ['id' => false, 'primary_key' => 'event_id']);
		$table->addColumn('event_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
		$table->addColumn('duration', 'integer', ['signed' => false, 'limit' => 11, 'null' => true]);

		$table->addForeignKey(
				'event_id',
				'event',
				'event_id',
				['constraint' => 'FK_event_duration_event', 'update' => 'CASCADE', 'delete' => 'CASCADE']
		);

		$table->create();
	}
}
