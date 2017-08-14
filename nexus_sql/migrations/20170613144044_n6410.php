<?php

class N6410 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('fare_product');
	    $table->addColumn('is_comment_required', 'boolean',
	                      ['default' => 0, 'null' => false, 'signed' => false, 'after' => 'is_account_created']);
	    $table->update();
    }
}
