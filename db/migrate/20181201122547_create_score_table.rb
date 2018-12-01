class CreateScoreTable < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :game
      t.references :player
      t.integer :points
    end
  end
end
