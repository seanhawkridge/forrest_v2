class AddPlayersToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :player_one_id, :integer
    add_column :matches, :player_two_id, :integer
  end
end
