require 'slack-notifier'

class MatchNotifier

  CLOSE_RESULT_MESSAGES = ['almost there!', 'that was close.', 'super close.',
                          'tight!', 'maybe the pressure got to you?']
  MEDIUM_RESULT_MESSAGES = ['try harder.', 'step it up.', 'try again.',
                           'life is like a box of chocolates. Or is it?']
  THRASHING_RESULT_MESSAGES = ['even Dwain would beat you.',
                       'have you considered lawn bowls?',
                       'were you playing with your eyes closed?',
                       'time to retire the paddle, friend.']

  def self.tournament_result_notification match
    message = "#{slack_intro match}" +
              "#{match.winner.first_name} moves into #{match.stage}\n" +
              "#{slack_insult match}"
    notify_slack message
  end

  def self.challenge_result_notification match
    message = "#{slack_intro match}" +
              "#{match.winner.name} #{match.winner_position_action} #{match.winner.position.ordinalize} place!\n" +
              "#{match.loser.name} #{match.loser_position_action} #{match.loser.position.ordinalize}...\n" +
              "#{slack_insult match}"
    notify_slack message
  end

  private

  def self.notify_slack message
    notifier = Slack::Notifier.new ENV["WEBHOOK_URL"]
    notifier.ping message
  end

  def self.slack_intro match
    ":table_tennis_paddle_and_ball: " +
    "#{match.winner.name_with_nickname} just beat #{match.loser.name_with_nickname}.\n" +
    "The score was #{match.winning_score} : #{match.losing_score}.\n"
  end

  def self.slack_insult match
    "#{match.loser.last_name} - #{insult_loser(match.winning_score, match.losing_score)}"
  end

  def self.insult_loser winning_score, losing_score
    if losing_score.to_i > (winning_score.to_i * 0.7)
      CLOSE_RESULT_MESSAGES.sample
    elsif losing_score.to_i >= (winning_score.to_i * 0.5)
      MEDIUM_RESULT_MESSAGES.sample
    else
      THRASHING_RESULT_MESSAGES.sample
    end
  end

end
