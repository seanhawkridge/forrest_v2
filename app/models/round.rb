class Round < ApplicationRecord

  belongs_to :tournament
  has_many :matches

  def create_match(player_one, player_two)
    if player_two == :bye
      matches << matches.create(player_one: player_one, bye: true)
    else
      matches << matches.create(player_one: player_one, player_two: player_two)
    end
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

  def stage
    is_final? ? "round #{number.to_s}" : "the final"
  end

  def tournament_name
    tournament.name
  end

  def update_byes
    matches.each { |match| match.win_by_bye if match.bye == true }
  end

end
