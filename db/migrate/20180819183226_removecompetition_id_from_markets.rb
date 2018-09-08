class RemovecompetitionIdFromMarkets < ActiveRecord::Migration[5.2]
  def change
    remove_column :markets, :competition_id
  end
end
