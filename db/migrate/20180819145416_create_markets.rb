class CreateMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :markets do |t|
      t.integer :q0
      t.integer :q1
      t.float :price

      t.timestamps
    end
  end
end
