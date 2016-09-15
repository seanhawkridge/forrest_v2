class ChangeDefaultForWinsOnPlayers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :players, :wins, 0
    change_column_default :players, :games, 0
  end
end
