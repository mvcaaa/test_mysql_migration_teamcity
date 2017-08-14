<?php

class N5665 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('user');
	    $table->addNexusForeignKeyColumn('age_group_id', ['null' => true, 'after' => 'organization_id'], 'age_group');
	    $table->update();
    }
}
