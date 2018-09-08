class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :share
      t.integer :q0
      t.integer :q1
      t.float :price

      t.timestamps
    end
  end
end
