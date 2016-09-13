class AddTournamentToRound < ActiveRecord::Migration[5.0]
  def change
    add_reference :rounds, :tournament, foreign_key: true
  end
end
