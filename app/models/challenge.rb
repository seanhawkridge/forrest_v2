class Challenge < ApplicationRecord

  belongs_to :challenger, class_name: 'Player'
  belongs_to :challenged, class_name: 'Player'
  belongs_to :winner, class_name: 'Player', optional: true

  scope :includes_player, -> (player) { where("status = ? AND (challenger_id = ? OR challenged_id = ?)",
                                       "open", player.id, player.id) }

  def open_challenge?
    status == "open"
  end

  def position_switch_on_refusal
    challenged.switch_places_with challenger
  end

end
