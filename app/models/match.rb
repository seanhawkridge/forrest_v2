require 'slack-notifier'

class Match < ApplicationRecord

  belongs_to :player_one, class_name: 'Player', optional: true
  belongs_to :player_two, class_name: 'Player', optional: true
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :round, optional: true

  scope :order_by_id, -> { order(id: :asc) }

  LOSER_MESSAGES = ['you suck', 'try harder', 'step it up', 'try again', 'even Dwain would beat you']

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
    message = ":table_tennis_paddle_and_ball: " +
    "#{results[:winner].name} just beat #{results[:loser].name}. " +
    "The score was #{results[:winning_score]} : #{results[:losing_score]}. " +
    "Go #{results[:winner].name}! #{results[:loser].name} - #{LOSER_MESSAGES.sample}."
    notifier.ping message
  end
end
