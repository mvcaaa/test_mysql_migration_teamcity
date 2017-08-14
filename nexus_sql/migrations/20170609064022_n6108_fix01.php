<?php

class N6108Fix01 extends NexusMigration
{
    public function up()
    {
	    $table = $this->table('module');
	    $table->changeColumn('image_url', 'string', ['null' => true, 'length' => 200]);
	    $table->changeColumn('activation_label', 'string', ['null' => true, 'length' => 100]);
	    $table->update();
    }

	public function down()
	{
		$table = $this->table('module');
		$table->changeColumn('image_url', 'string', ['null' => false, 'length' => 100]);
		$table->changeColumn('activation_label', 'string', ['null' => false, 'length' => 100]);
		$table->update();
	}
}
