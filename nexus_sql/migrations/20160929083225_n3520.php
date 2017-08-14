<?php

use Phinx\Migration\AbstractMigration;

class N3520 extends AbstractMigration
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
	    $table = $this->table('payment_type');
	    $table->addColumn('identity_check_probability', 'float', ['default' => 0, 'null' => false]);
	    $table->update();

	    $table = $this->table('access_right_identity_check', ['id' => false,
	                                                          'primary_key' => 'access_right_identity_check_id']);
	    $table->addColumn('access_right_identity_check_id', 'integer',
	                      ['signed' => false, 'limit' => 10, 'identity' => true]);

	    $table->addColumn('access_right_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addIndex('access_right_id', ['unique' => true]);
	    $table->addForeignKey('access_right_id', 'access_right', 'access_right_id', [
			    'constraint' => 'FK_access_right_identity_check_access_right',
			    'update' => 'CASCADE',
			    'delete' => 'CASCADE'
	    ]);

	    $table->addColumn('identity_check_probability', 'float', ['default' => 0, 'null' => false]);
	    $table->addColumn('is_identity_check_required', 'boolean', ['default' => false, 'signed' => false]);

	    $table->addColumn('last_check_event_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => true]);
	    $table->addForeignKey('last_check_event_id', 'event', 'event_id', [
			    'constraint' => 'FK_access_right_identity_check_event',
			    'update' => 'CASCADE',
			    'delete' => 'SET NULL'
	    ]);

	    $table->create();


    }
}
