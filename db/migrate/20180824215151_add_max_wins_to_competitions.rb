class AddMaxWinsToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :maxwins, :integer
  end
end
