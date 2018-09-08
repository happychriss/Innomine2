class AddIdeaToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_reference :markets, :idea, foreign_key: true
  end
end
