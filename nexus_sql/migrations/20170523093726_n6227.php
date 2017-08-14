<?php

class N6227 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('fare_product_tag',
			    ['id' => false, 'primary_key' => ['fare_product_id', 'tag_id']]);
	    $table->addNexusForeignKeyColumn('fare_product_id', ['delete' => 'CASCADE']);
	    $table->addNexusForeignKeyColumn('tag_id', ['delete' => 'CASCADE']);
	    $table->addColumn('value', 'string', ['limit' => 100, 'null' => true]);
	    $table->create();
    }
}
