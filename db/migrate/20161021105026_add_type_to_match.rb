class AddTypeToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :match_type, :string
  end
end
