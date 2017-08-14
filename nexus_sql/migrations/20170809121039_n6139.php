<?php

class N6139 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('location');
		$table->addColumn('is_publicly_visible', 'boolean',
		                  ['signed'  => false,
		                   'null'    => true,
		                   'default' => true,
		                   'after'   => 'is_active']);
		$table->update();

		$table = $this->table('resource');
		$table->addColumn('is_publicly_visible', 'boolean',
		                  ['signed'  => false,
		                   'null'    => true,
		                   'default' => true,
		                   'after'   => 'is_hidden_in_pos']);
		$table->update();
	}
}
