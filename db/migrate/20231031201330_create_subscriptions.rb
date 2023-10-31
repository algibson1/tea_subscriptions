class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.float :price
      t.string :frequency

      t.timestamps
    end
  end
end
