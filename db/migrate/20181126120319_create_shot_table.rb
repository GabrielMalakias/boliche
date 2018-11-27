class CreateShotTable < ActiveRecord::Migration[5.2]
  def change
    create_table :shots do |t|
      t.references :frame
      t.integer :knocked_down_pins
    end
  end
end
