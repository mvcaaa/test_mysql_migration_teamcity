<?php

class N5651 extends NexusMigration
{
	public function up()
	{
		if ($this->hasTable('receipt_session')) {
			$this->dropTable('receipt_session');
		}

		$table = $this->table('session', ['nexus_primary' => true]);
		$table->addNexusForeignKeyColumn('user_id', ['null' => true, 'delete' => 'CASCADE'], 'user');
		$table->addColumn('session_json', 'text', ['null' => false]);
		$table->create();
	}

	public function down()
	{
		$table = $this->table('receipt_session',
				['id' => false, 'identity' => false, 'primary_key' => 'receipt_event_id']);
		$table->addNexusForeignKeyColumn('receipt_event_id', ['delete' => 'CASCADE'], 'event');
		$table->addColumn('session_json', 'text', ['null' => false]);
		$table->create();

		if ($this->hasTable('session')) {
			$this->dropTable('session');
		}
	}
}
