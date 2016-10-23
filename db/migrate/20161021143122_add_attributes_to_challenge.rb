class AddAttributesToChallenge < ActiveRecord::Migration[5.0]
  def change
    add_reference :challenges, :match, foreign_key: true
    add_column :challenges, :challenger_id, :integer
    add_column :challenges, :challenged_id, :integer
    add_column :challenges, :status, :string
    add_column :challenges, :result, :string
  end
end
