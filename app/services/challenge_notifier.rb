require 'slack-notifier'

class ChallengeNotifier

  def self.challenge_invitation_notification challenge: challenge, url: url
    message = ":muscle: #{challenge.challenged.slack_name}: #{challenge.challenger.name} has challenged you!\n" +
              "<#{url}|Click here> to accept or refuse the challenge!"
    notify_slack message
  end

  def self.challenge_accepted_notification match: match, url: url
    message = ":muscle: #{match.player_one.slack_name}: #{match.player_two.name} has accepted your challenge!\n" +
              "Play the match and then <#{url}|Click here> to log scores!"
    notify_slack message
  end

  private

  def self.notify_slack message
    notifier = Slack::Notifier.new ENV["WEBHOOK_URL"]
    notifier.ping message
  end

end
