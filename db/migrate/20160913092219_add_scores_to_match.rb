class AddScoresToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :player_one_score, :integer
    add_column :matches, :player_two_score, :integer
  end
end
