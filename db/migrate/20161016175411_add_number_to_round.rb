class AddNumberToRound < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :number, :integer
  end
end
