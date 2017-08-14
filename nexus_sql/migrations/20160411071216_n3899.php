<?php

use Phinx\Migration\AbstractMigration;

class N3899 extends AbstractMigration
{
	public function up()
	{
		$this->execute("REPLACE INTO edit_type VALUES (" . EDIT_UPDATE_RELATION . ", 'Update Relation')");
	}

	public function down()
	{
		$this->execute("DELETE FROM edit_type WHERE edit_type_id = " . EDIT_UPDATE_RELATION);
	}
}
