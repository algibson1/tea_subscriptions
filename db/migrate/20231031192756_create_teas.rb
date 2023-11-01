class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :blend_name
      t.integer :tea_type
      t.string :description
      t.integer :brew_temperature
      t.integer :brew_time

      t.timestamps
    end
  end
end
