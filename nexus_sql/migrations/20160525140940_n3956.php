<?php

use Phinx\Migration\AbstractMigration;

class N3956 extends AbstractMigration
{
	public function up()
	{
		$table = $this->table('campaign');
		$table->changeColumn('sale_group_id', 'integer',
		                     ['signed' => false,
		                      'null'   => true,
		                      'limit'  => 10]);

	}

	public function down()
	{
		$table = $this->table('campaign');
		$table->dropForeignKey('sale_group_id');

		$table->changeColumn('sale_group_id', 'integer',
		                     ['signed' => false,
		                      'null'   => false,
		                      'limit'  => 10]);

		$table->addForeignKey('sale_group_id', 'sale_group', 'sale_group_id',
		                      ['constraint' => 'FK_campaign_sale_group',
		                       'update'     => 'CASCADE',
		                       'delete'     => 'CASCADE']);

		$table->update();
	}
}
