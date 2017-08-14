<?php

use Phinx\Migration\AbstractMigration;

class N4153AddReservationTag extends AbstractMigration
{
    public function change()
    {
      $table = $this->table('reservation_tag', ['id' => false, 'primary_key' => 'reservation_tag_id']);
      $table->addColumn('reservation_tag_id', 'integer', ['signed' => false, 'limit' => 10, 'identity' => true]);

      $table->addColumn('reservation_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
      $table->addColumn('tag_id', 'integer', ['signed' => false, 'limit' => 10, 'null' => false]);
      $table->addColumn('value', 'text', ['default' => null, 'null' => true]);

      $table->addForeignKey('reservation_id', 'reservation', 'reservation_id', [
        'constraint' => 'FK_reservation_tag_reservation',
        'update' => 'CASCADE',
        'delete' => 'RESTRICT'
      ]);

      $table->addForeignKey('tag_id', 'tag', 'tag_id', [
        'constraint' => 'FK_reservation_tag_tag',
        'update' => 'CASCADE',
        'delete' => 'RESTRICT'
      ]);

      $table->create();
    }
}
