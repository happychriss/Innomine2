class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.string :competition_name
      t.integer :max_markets
      t.integer :market_velocity_b

      t.timestamps
    end
  end
end
