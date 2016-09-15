class AddByeToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :bye, :boolean, default: false
  end
end
