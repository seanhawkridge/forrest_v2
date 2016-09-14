class AddStatsToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :games, :integer
    add_column :players, :wins, :integer
    add_column :players, :win_percentage, :integer
  end
end
