class CreateFrameTable < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.references :player
      t.references :game
      t.integer :score
      t.integer :number
      t.integer :status, default: 0
    end
  end
end
