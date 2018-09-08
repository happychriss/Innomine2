class AddCompetitionToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_reference :markets, :competition, foreign_key: true
  end
end
