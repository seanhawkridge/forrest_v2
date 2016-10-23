class AddChallengeToMatch < ActiveRecord::Migration[5.0]
  def change
    add_reference :matches, :challenge, index: true
  end
end
