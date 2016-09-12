class DropTournamentPlayers < ActiveRecord::Migration[5.0]
  def change
    drop_table :tournament_players
  end
end
