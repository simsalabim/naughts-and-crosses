class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :rows_size
      t.integer :columns_size
      t.integer :winning_row_size
      t.integer :active_player_id
      t.integer :winner_id
      t.boolean :completed, default: false, null: false
      t.text :winner_row

      t.timestamps null: false
    end
  end
end
