<?php

use Phinx\Migration\AbstractMigration;
use Phinx\Db\Table;

class NexusMigration extends AbstractMigration
{
	public function table($tableName, $options = [])
	{
		$nexus_primary = @$options['nexus_primary'];
		unset($options['nexus_primary']);

		if ($nexus_primary) {
			$options['id'] = false;
			$options['primary_key'] = $tableName . '_id';
		}
		$table = new NexusTable($tableName, $options, $this->getAdapter());
		if ($nexus_primary) $table->addPrimaryKeyColumn();
		return $table;
	}
}

class NexusTable extends Table
{
	/**
	 * Creates Nexus style foreign key column, accepts only a single column
	 * If not specified referenced table and column are going to be inferred
	 * @param string $column_name
	 * @param array  $options
	 * @param bool   $referenced_table optional, if missing the table is going to be guessed from the $column_name
	 */
	public function addNexusForeignKeyColumn($column_name, $options = [], $referenced_table = false)
	{
		$options['null'] = @$options['null'] ?: false;
		$options['default'] = @$options['default'] ?: null;

		$column_options = [
				'signed' => false,
				'limit' => 10,
				'null' => $options['null'],
				'default' => $options['default']
		];
		if (@$options['after']) $column_options['after'] = $options['after'];
		$this->addColumn($column_name, 'integer', $column_options);

		$options['update'] = @$options['update'] ?: 'CASCADE';
		$options['delete'] = @$options['delete'] ?: 'RESTRICT';
		$referenced_table = $referenced_table ?: substr($column_name, 0, -3);
		$referenced_column = $referenced_table . '_id';
		$constraint = 'FK_' . $this->getName() . '_' . $column_name;

		$this->addForeignKey($column_name, $referenced_table, $referenced_column, [
			'constraint' => $constraint,
			'update'     => $options['update'],
			'delete'     => $options['delete']
		]);
	}

	public function addIsActiveColumn($default = 1)
	{
		$this->addColumn('is_active', 'boolean', ['default' => $default, 'null' => false, 'signed' => false]);
	}

	public function addNameColumn($options = [])
	{
		$options['limit'] = @$options['limit'] ?: 50;
		$options['null'] = @$options['null'] ?: false;
		$this->addColumn('name', 'string', ['limit' => 50, 'null' => false]);
	}

	public function addPrimaryKeyColumn()
	{
		$this->addColumn($this->getName() . '_id', 'integer',
		                 ['signed' => false, 'limit' => 10, 'identity' => true]);
	}
}