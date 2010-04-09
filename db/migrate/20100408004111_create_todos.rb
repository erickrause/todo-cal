class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :summary
      t.text :description
      t.datetime :due

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
