require 'active_support/core_ext/integer/inflections'

class Match < ApplicationRecord

  belongs_to :player_one, class_name: 'Player', optional: true
  belongs_to :player_two, class_name: 'Player', optional: true
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :round, optional: true

  scope :order_by_id, -> { order(id: :asc) }
  scope :with_results, -> { where.not(winner: nil).where(bye: false).order(updated_at: :desc) }

  def update_results p1_score, p2_score
    update winner: calculate_winner(p1_score, p2_score),
           player_one_score: p1_score, player_two_score: p2_score
    update_stats
  end

  def update_positions
    if winner.position > loser.position
      update successful_challenge: true
      switch_positions
    end
  end

  def winner_position_action
    successful_challenge == true ? "climbs up to" : "stays at"
  end

  def loser_position_action
    successful_challenge == true ? "slips down to" : "is stuck at"
  end

  def player_placeholder
    bye == true ? "bye" : "???"
  end

  def win_by_bye
    update winner: player_one
  end

  def includes_player? player_id
    player_one && player_one.id == player_id || player_two && player_two.id == player_id
  end

  def ready_to_play?
    (player_one.is_a? Player) && (player_two.is_a? Player)
  end

  def calculate_winner p1_score, p2_score
    p1_score.to_i > p2_score.to_i ? player_one : player_two
  end

  def loser
    player_one == winner ? player_two : player_one
  end

  def winning_score
    player_one == winner ? player_one_score : player_two_score
  end

  def losing_score
    player_one == winner ? player_two_score : player_one_score
  end

  def stage
    round.stage
  end

  def tournament_name
    round.tournament_name
  end

  private

  def switch_positions
    up_position = loser.position
    down_position = winner.position
    winner.update_position up_position
    loser.update_position down_position
  end

  def update_stats
    winner.update_win_count
    winner.update_stats
    loser.update_stats
  end
end
