<?php

use Phinx\Migration\AbstractMigration;

class N4293 extends AbstractMigration
{
	public function change()
	{
		$table_name = 'organization_payment_type_surplus';
		$primary_key = 'organization_payment_type_surplus_id';

		$fields = [
				$primary_key,
				'organization_payment_type_id',
				'fare_product_id',
				'location_id'
		];

		$table_options = [
				'id' => false,
				'primary_key' => $primary_key,
		];

		$field_options = [
				'signed' => false,
				'null' => false,
				'limit' => 10
		];

		$fk_options = [
				'constraint' => null,
				'delete' => 'CASCADE',
				'update' => 'CASCADE'
		];

		$table = $this->table($table_name, $table_options);

		foreach ($fields as $field) {
			if ($field == $primary_key) {
				$table->addColumn($field, 'integer', array_merge($field_options, ['identity' => true]));
			}
			else {
				$table->addColumn($field, 'integer', array_merge($field_options, ['default' => 0]));
				$ref_table = preg_replace('/_id$/', '', $field);
				$fk_options['constraint'] = "FK_{$table_name}_{$ref_table}";
				$table->addForeignKey($field, $ref_table, $field, $fk_options);
			}
		}

		$table->addIndex(array_splice($fields, 1), ['unique' => true]);
		$table->create();
	}
}
