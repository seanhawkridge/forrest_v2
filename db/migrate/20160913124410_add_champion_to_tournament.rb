class AddChampionToTournament < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :champion_id, :integer
  end
end
