class AddWinnerToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :winner_id, :integer
  end
end
