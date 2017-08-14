<?php

use Phinx\Migration\AbstractMigration;

class N5897 extends AbstractMigration
{
    public function up()
    {
	    $table = $this->table('reservation_application');
	    $table->changeColumn('date_start', 'date', ['null' => true]);
	    $table->changeColumn('date_end', 'date', ['null' => true]);
	    $table->save();
    }

	public function down()
	{
		$table = $this->table('reservation_application');
		$table->changeColumn('date_start', 'date', ['null' => false]);
		$table->changeColumn('date_end', 'date', ['null' => false]);
		$table->save();
	}
}
