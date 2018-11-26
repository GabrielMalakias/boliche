class CreateGameTable < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :current_player, :player
    end
  end
end
