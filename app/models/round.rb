class Round < ApplicationRecord

  belongs_to :tournament
  has_many :matches

  def create_match(player_one, player_two)
    matches << matches.create(player_one: player_one, player_two: player_two)
  end

  def collect_winners
    matches.map { |match| match.winner }
  end

  def is_final?
    matches.size == 1
  end

  def final_winner
    is_final? ? matches.first.winner : nil
  end

end
