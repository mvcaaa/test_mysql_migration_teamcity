<?php

use Phinx\Migration\AbstractMigration;

class N4369 extends AbstractMigration
{
	public function change()
	{
		$table_name = 'event_transfer_reservation';
		$primary_key = 'event_id';

		$table = $this->table($table_name, ['id' => false, 'primary_key' => $primary_key]);
		$table->addColumn($primary_key, 'integer', ['signed' => false, 'limit' => 10]);

		$field_options = ['signed' => false, 'limit' => 10, 'default' => null, 'null' => true];
		$fk_options = ['constraint' => null, 'update' => 'CASCADE', 'delete' => 'CASCADE'];

		$table->addColumn('new_reservation_event_id', 'integer', $field_options);
		$table->addForeignKey(
				'new_reservation_event_id',
				'reservation_event',
				'reservation_event_id',
				array_merge($fk_options, ['constraint' => "FK_{$table_name}_reservation_event"])
		);

		$table->addColumn('new_reservation_event_group_id', 'integer', $field_options);
		$table->addForeignKey(
				'new_reservation_event_group_id',
				'reservation_event_group',
				'reservation_event_group_id',
				array_merge($fk_options, ['constraint' => "FK_{$table_name}_reservation_event_group"])
		);

		$table->create();
	}
}
