class AddPositionToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :position, :integer
  end
end
