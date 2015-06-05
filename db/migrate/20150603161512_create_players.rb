class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :strategy
      t.string :token
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
