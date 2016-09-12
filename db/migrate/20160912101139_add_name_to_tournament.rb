class AddNameToTournament < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :name, :string
  end
end
