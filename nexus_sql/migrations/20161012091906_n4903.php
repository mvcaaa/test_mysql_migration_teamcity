<?php

use Phinx\Migration\AbstractMigration;

class N4903 extends AbstractMigration
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
	    $table = $this->table('cta_budget', ['id'          => false,
	                                         'primary_key' => 'cta_budget_id']);
	    $table->addColumn('cta_budget_id', 'integer',
	                      ['signed' => false, 'limit' => 10, 'identity' => true]);

	    $table->addColumn('agreement_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addForeignKey('agreement_id', 'agreement', 'agreement_id', [
		    'constraint' => 'FK_cta_budget_agreement',
		    'update' => 'CASCADE',
		    'delete' => 'RESTRICT'
	    ]);

	    $table->addColumn('is_closed', 'boolean', ['default' => false, 'signed' => false, 'null' => false]);
	    $table->addColumn('is_active', 'boolean', ['default' => true, 'signed' => false, 'null' => false]);

	    $table->create();

	    // =================

	    $table = $this->table('cta_budget_row', ['id'          => false,
	                                         'primary_key' => 'cta_budget_row_id']);
	    $table->addColumn('cta_budget_row_id', 'integer',
	                      ['signed' => false, 'limit' => 10, 'identity' => true]);

	    $table->addColumn('cta_budget_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addForeignKey('cta_budget_id', 'cta_budget', 'cta_budget_id', [
		    'constraint' => 'FK_cta_budget_row_cta_budget',
		    'update' => 'CASCADE',
		    'delete' => 'CASCADE'
	    ]);

	    $table->addColumn('agreement_product_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addForeignKey('agreement_product_id', 'agreement_product', 'agreement_product_id', [
		    'constraint' => 'FK_cta_budget_row_agreement_product',
		    'update' => 'CASCADE',
		    'delete' => 'RESTRICT'
	    ]);

	    $table->addColumn('price', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
	    $table->addColumn('quantity', 'integer', ['signed' => true, 'limit' => 10, 'null' => false]);
	    $table->addColumn('date_start', 'date', ['null' => false]);
	    $table->addColumn('date_end', 'date', ['null' => false]);

	    $table->addColumn('is_active', 'boolean', ['default' => true, 'signed' => false, 'null' => false]);

	    $table->create();

	    $table = $this->table('agreement_product');
	    $table->addColumn('account_number', 'string', ['default' => 0, 'null' => false, 'limit' => 50]);
	    $table->update();
    }
}
