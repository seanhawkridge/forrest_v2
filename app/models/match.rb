require 'slack-notifier'

class Match < ApplicationRecord

  belongs_to :player_one, class_name: 'Player', optional: true
  belongs_to :player_two, class_name: 'Player', optional: true
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :round, optional: true

  scope :order_by_id, -> { order(id: :asc) }
  scope :with_results, -> { where.not(winner: nil).where(bye: false).order(updated_at: :desc) }

  CLOSE_RESULT_MESSAGES = ['almost there!', 'that was close.', 'super close.',
                          'tight!', 'maybe the pressure got to you?']
  MEDIUM_RESULT_MESSAGES = ['try harder.', 'step it up.', 'try again.',
                           'life is like a box of chocolates. Or is it?']
  THRASHING_RESULT_MESSAGES = ['even Dwain would beat you.',
                       'have you considered lawn bowls?',
                       'were you playing with your eyes closed?',
                       'time to retire the paddle, friend.']

  def update_results p1_score, p2_score
    results = calculate_results p1_score, p2_score
    update_stats results
    update_attributes(winner: results[:winner], player_one_score: p1_score, player_two_score: p2_score)
    notify_slack results
  end

  def player_placeholder
    bye == true ? "bye" : "player"
  end

  def win_by_bye
    self.update_attributes(winner: player_one)
  end

  def includes_player? player_id
    player_one && player_one.id == player_id || player_two && player_two.id == player_id
  end

  def loser
    player_one == winner ? player_two : player_one
  end

  def scores
    if player_one == winner
      { winning_score: player_one_score, losing_score: player_two_score }
    else
      { winning_score: player_two_score, losing_score: player_one_score }
    end
  end

  private

  def calculate_results p1_score, p2_score
    if p1_score > p2_score
      {winner: player_one, loser: player_two, winning_score: p1_score, losing_score: p2_score}
    else
      {winner: player_two, loser: player_one, winning_score: p2_score, losing_score: p1_score}
    end
  end

  def update_stats results
    results[:winner].update_win_count
    results[:winner].update_stats
    results[:loser].update_stats
  end

  def notify_slack results
    notifier = Slack::Notifier.new ENV["WEBHOOK_URL"]
    message = slack_message results
    notifier.ping message
  end

  def slack_message results
    ":table_tennis_paddle_and_ball: " +
    "#{results[:winner].name_with_nickname} just beat #{results[:loser].name_with_nickname}. " +
    "The score was #{results[:winning_score]} : #{results[:losing_score]}. " +
    "Go #{results[:winner].first_name}! " +
    "#{results[:loser].last_name} - #{insult_loser(results[:winning_score], results[:losing_score])}"
  end

  def insult_loser winning_score, losing_score
    if losing_score.to_i > (winning_score.to_i * 0.7)
      CLOSE_RESULT_MESSAGES.sample
    elsif losing_score.to_i >= (winning_score.to_i * 0.5)
      MEDIUM_RESULT_MESSAGES.sample
    else
      THRASHING_RESULT_MESSAGES.sample
    end
  end
end
