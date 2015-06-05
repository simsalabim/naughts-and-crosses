class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :player_id
      t.integer :row
      t.integer :column
      t.string :token

      t.timestamps null: false
    end
  end
end
