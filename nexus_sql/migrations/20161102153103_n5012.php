<?php

use Phinx\Migration\AbstractMigration;

class N5012 extends AbstractMigration
{
    /**
     * Change Method.
     *
     * Write your reversible migrations using this method.
     *
     * More information on writing migrations is available here:
     * http://docs.phinx.org/en/latest/migrations.html#the-abstractmigration-class
     *
     * The following commands can be used in this method and Phinx will
     * automatically reverse them when rolling back:
     *
     *    createTable
     *    renameTable
     *    addColumn
     *    renameColumn
     *    addIndex
     *    addForeignKey
     *
     * Remember to call "create()" or "update()" and NOT "save()" when working
     * with the Table class.
     */
    public function change()
    {
	    $table = $this->table('field_type', ['id' => false, 'primary_key' => 'field_type_id']);
	    $table->addColumn('field_type_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);
	    $table->addColumn('name', 'string', ['limit' => 100, 'null' => false]);
	    $table->addColumn('data_type', 'string', ['limit' => 100, 'default' => null, 'null' => true]);
	    $table->addColumn('validation_regex', 'text', ['default' => null, 'null' => true]);
	    $table->addColumn('description', 'text', ['default' => null, 'null' => true]);
	    $table->addColumn('example', 'text', ['default' => null, 'null' => true]);
	    $table->addColumn('reference', 'string', ['limit' => 100, 'default' => null, 'null' => true]);
	    $table->create();

	    $table = $this->table('field');
	    $options = ['signed' => false, 'limit' => 10, 'null' => true, 'after' => 'field_group_id'];
	    $table->addColumn('field_type_id', 'integer', $options);
	    $table->addForeignKey('field_type_id', 'field_type', 'field_type_id', [
			    'constraint' => 'FK_field_field_type',
			    'update' => 'CASCADE',
			    'delete' => 'SET NULL'
	    ]);
	    $table->update();
    }
}
