<?php

use Phinx\Migration\AbstractMigration;

class N4153AddUniqueKeyToReservationTag extends AbstractMigration
{
    public function up()
    {
	    $table = $this->table('reservation_tag');
	    $table->addIndex(['reservation_id', 'tag_id'], ['unique' => true]);
	    $table->update();
    }

    public function down()
    {
	    $table = $this->table('reservation_tag');
	    $table->dropForeignKey('reservation_id');
	    $table->removeIndex(['reservation_id', 'tag_id'], ['unique' => true]);
	    $table->addForeignKey('reservation_id', 'reservation', 'reservation_id', ['update' => 'CASCADE']);
	    $table->update();
    }
}
