<?php

use Phinx\Migration\AbstractMigration;

class N5148 extends AbstractMigration
{
    public function change()
    {
	    $table = $this->table('event_locker');
	    $options = ['default' => false, 'null' => false, 'signed' => false];
	    $table->addColumn('is_notification_sent', 'boolean', $options)->update();
    }
}
