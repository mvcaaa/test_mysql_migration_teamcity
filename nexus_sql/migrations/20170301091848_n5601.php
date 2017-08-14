<?php

class N5601 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('reservation_event_group_tag',
		                      ['id' => false, 'primary_key' => ['reservation_event_group_id', 'tag_id']]);
		$table->addNexusForeignKeyColumn('reservation_event_group_id', ['delete' => 'CASCADE']);
		$table->addNexusForeignKeyColumn('tag_id', ['delete' => 'CASCADE']);
		$table->addColumn('value', 'string', ['limit' => 100, 'null' => true]);
		$table->create();
	}
}
