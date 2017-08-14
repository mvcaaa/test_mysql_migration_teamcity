<?php

class N6152 extends NexusMigration
{
	public function change()
	{
		$table = $this->table('payment_type');
		$table->addColumn('is_negative_allowed', 'boolean', ['default' => 0, 'null' => false, 'signed' => false]);
		$table->addIsActiveColumn();
		$table->update();

		// set negative allowed to true for cash and palvelu kassa: PT_CASH and PT_PALVELUKASSA
		$this->query("UPDATE payment_type SET is_negative_allowed = 1 WHERE payment_type_id IN (1, 10)");
	}
}
