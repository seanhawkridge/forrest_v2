class AddSuccessfulChallengeToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :successful_challenge, :boolean, default: false
  end
end
