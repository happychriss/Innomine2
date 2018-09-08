class AddCompetitionToIdeas < ActiveRecord::Migration[5.2]
  def change
    add_reference :ideas, :competition, foreign_key: true
  end
end
