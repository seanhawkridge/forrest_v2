require 'active_support/core_ext/integer/inflections'

class Match < ApplicationRecord

  before_create :set_nicknames

  belongs_to :player_one, class_name: 'Player', optional: true
  belongs_to :player_two, class_name: 'Player', optional: true
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :round, optional: true
  belongs_to :challenge, optional: true

  scope :order_by_id, -> { order(id: :asc) }
  scope :with_results, -> { where.not(winner: nil).where(bye: false).order(updated_at: :desc) }
  scope :with_challenge, -> (challenge_id) { where(challenge_id: challenge_id )}
  scope :open_challenge, -> (player) {where("winner = ? AND match_type = ? AND (player_one = ? OR player_two = ?)", nil, "challenge", player, player)}

  def update_results p1_score, p2_score
    update winner: calculate_winner(p1_score, p2_score),
           player_one_score: p1_score, player_two_score: p2_score
    update_stats
  end

  def update_positions
    position_gain if winner.position > loser.position
    demote_challenger if (loser == player_one) && (loser.places_below winner, 2)
  end

  def position_gain
    update successful_challenge: true
    winner.switch_places_with loser
  end

  def demote_challenger
    loser.forfeit_place unless loser.is_bottom?
  end

  def winner_position_action
    successful_challenge == true ? "climbs up to" : "stays at"
  end

  def loser_position_action
    (successful_challenge == true) || (loser.places_below winner, 3) ? "slips down to" : "is stuck at"
  end

  def player_placeholder
    bye == true ? "bye" : "???"
  end

  def win_by_bye
    update winner: player_one
  end

  def includes_player? player_id
    [player_one.id, player_two.id].include? player_id
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

  def is_challenge?
    match_type == "challenge"
  end

  def is_tournament?
    match_type == "tournament"
  end

  def is_final?
    round.is_final?
  end

  private

  def update_stats
    winner.update_win_count
    winner.update_stats
    loser.update_stats
  end

  def set_nicknames
    [player_one, player_two].each { |player| player.try(:new_nickname) }
  end

end
