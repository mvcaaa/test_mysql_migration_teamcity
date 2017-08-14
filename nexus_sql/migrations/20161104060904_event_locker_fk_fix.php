<?php

use Phinx\Migration\AbstractMigration;

class EventLockerFkFix extends AbstractMigration
{
	/**
	 * Change Method.
	 *
	 * Write your reversible migrations using this method.
	 *
	 * More information on writing migrations is available here:
	 * http://docs.phinx.org/en/latest/migrations.html#the-abstractmigration-class
	 *
	 * The following commands can be used in this method and Phinx will
	 * automatically reverse them when rolling back:
	 *
	 *    createTable
	 *    renameTable
	 *    addColumn
	 *    renameColumn
	 *    addIndex
	 *    addForeignKey
	 *
	 * Remember to call "create()" or "update()" and NOT "save()" when working
	 * with the Table class.
	 */
	public function change()
	{
		// delete event_locker rows that don't have a valid locker_id (they are useless anyway)
		$this->execute("
			DELETE event_locker
			FROM event_locker
			LEFT JOIN locker l USING (locker_id)
			WHERE l.locker_id IS NULL
			");
		$table = $this->table('event_locker');
		$table->addForeignKey('locker_id', 'locker', 'locker_id', [
			'constraint' => 'FK_field_locker',
			'update'     => 'CASCADE',
			'delete'     => 'CASCADE'
		]);
		$table->update();
	}
}
