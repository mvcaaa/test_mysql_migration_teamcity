<?php

class N5865 extends NexusMigration
{
    public function change()
    {
	    $table = $this->table('building', ['nexus_primary' => true]);
	    $table->addNameColumn();
	    $table->addNexusForeignKeyColumn('location_id', ['null' => false]);
	    $table->addIsActiveColumn();
	    $table->create();

	    $table = $this->table('floor', ['nexus_primary' => true]);
	    $table->addNameColumn();
	    $table->addNexusForeignKeyColumn('building_id', ['null' => false]);
	    $table->addIsActiveColumn();
	    $table->create();

	    $table = $this->table('access_area');
	    $table->addNexusForeignKeyColumn('building_id', ['null' => true, 'after' => 'location_id']);
	    $table->addNexusForeignKeyColumn('floor_id', ['null' => true, 'after' => 'building_id']);
	    $table->update();
    }
}
