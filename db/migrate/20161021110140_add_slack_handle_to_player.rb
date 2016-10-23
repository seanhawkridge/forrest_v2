class AddSlackHandleToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :slack_handle, :string
  end
end
