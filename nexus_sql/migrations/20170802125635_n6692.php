<?php

class N6692 extends NexusMigration
{
	public function up()
	{
		$this->execute(" UPDATE `user` SET email = NULL WHERE email = '' ");
		$this->execute(" UPDATE `user` SET phone_number = NULL WHERE phone_number = '' ");
	}

	public function down()
	{

	}
}
