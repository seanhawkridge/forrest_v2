class Player < ApplicationRecord

  belongs_to :user, dependent: :destroy
  has_many :players_tournaments
  has_many :tournaments, through: :players_tournaments

  scope :selected, -> (tournament) { includes(:tournaments).where(tournaments: {id: tournament.id}) }
  scope :not_selected, -> (tournament) { all.order(:first_name) - selected(tournament) }
  scope :reverse_alphabetical, -> { all.order(:first_name).reverse_order }
  scope :alphabetical, -> { all.order(:first_name) }
  scope :position, -> { all.order(:position) }
  scope :ladder_challengeable, -> (current_player) { where( "position < ? AND position >= ?", current_player.position, (current_player.position - 2) ) }
  scope :one_below, -> (player) { where("(position - 1) = ?", player.position).first }

  NICKNAMES = ['Pocket Rocket', 'Spin Drier', 'Legend', 'Boss', 'Big Man',
              'Delicate Touch', 'Sunday Driver', 'Shrimper', 'Swerver',
              'Warrior Princess', 'Fingers', 'Backhand', 'Forehand', 'Bounty Hunter',
              'Returner', 'Fly Swat', 'Bendy', 'Daddy', 'Eyeballs',
              'Crazy Eyes', 'Wrist', 'Twister', 'Punisher', 'Assassin', 'Piano Man',
              'Ball-breaker', 'Crusher', 'Wet Blanket', 'Whippet', 'Joker', 'Clown',
              'Lumberjack', 'Wizard', 'Shadow', 'One', 'Space Bar', 'Escape Key',
              'Matador', 'Hawk', 'Bear', 'Wolf', 'Fist', 'Wrist-o']

  def update_stats
    update games: update_games_count, win_percentage: calculate_win_percentage
    update points: calculate_points
  end

  def update_win_count
    self.wins += 1
  end

  def update_games_count
    self.games += 1
  end

  def switch_places_with player
    original_position = position
    updated_position = player.position
    update position: updated_position
    player.update position: original_position
  end

  def update_position new_position
    update position: new_position
  end

  def has_open_challenge?
    (Challenge.includes_player self).any?
  end

  def free_to_challenge?
    (Challenge.includes_player self).empty?
  end

  def current_challenge
    (Challenge.includes_player self).first
  end

  def current_challenge_includes_player? player
    current_challenge.challenger == player || current_challenge.challenged == player
  end

  def is_bottom?
    position == Player.maximum(:position)
  end

  def places_below player, number
    position == player.position + number
  end

  def forfeit_place
    switch_places_with Player.one_below self
  end

  def calculate_win_percentage
    (wins.to_f/games) * 100
  end

  def calculate_points
    wins * win_percentage
  end

  def new_nickname
    update nickname: NICKNAMES.sample
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name_with_nickname
    "#{first_name} 'The #{nickname}' #{last_name}"
  end

  def slack_name
    slack_handle ? "<#{slack_handle}>" : first_name
  end
end
