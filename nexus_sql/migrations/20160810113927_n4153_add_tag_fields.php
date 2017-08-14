<?php

use Phinx\Migration\AbstractMigration;

class N4153AddTagFields extends AbstractMigration
{
    public function change()
    {
      $table = $this->table('tag');
      $table->addColumn('ui_order', 'integer', ['signed' => false, 'limit' => 10, 'null' => false, 'default' => 0]);
      $table->addColumn('is_required', 'boolean', ['default' => false, 'signed' => false]);
      $table->addColumn('possible_values', 'text', ['default' => null, 'null' => true]);
      $table->update();
    }
}
