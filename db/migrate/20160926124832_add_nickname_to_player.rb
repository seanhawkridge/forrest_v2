class AddNicknameToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :nickname, :string
  end
end
