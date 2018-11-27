class CreateGameTable < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :current_player, :player
      t.integer :frame_number, default: 0
    end
  end
end
