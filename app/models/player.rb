class Player < ApplicationRecord

  belongs_to :user, dependent: :destroy
  has_many :players_tournaments
  has_many :tournaments, through: :players_tournaments

  scope :selected, -> (tournament) { includes(:tournaments).where(tournaments: {id: tournament.id}) }
  scope :not_selected, -> (tournament) { all.order(:first_name) - selected(tournament) }
  scope :by_win_percantage, -> { order(wins: :desc).order(win_percentage: :desc) }
  scope :reverse_alphabetical, -> { all.order(:first_name).reverse_order }
  scope :alphabetical, -> { all.order(:first_name) }

  NICKNAMES = ['Pocket Rocket', 'Spin Drier', 'Legend', 'Boss', 'Big Man',
              'Delicate Touch', 'Sunday Driver', 'Shrimper', 'Swerver',
              'Warrior Princess', 'Fingers', 'Backhand', 'Forehand', 'Bounty Hunter',
              'Returner', 'Fly Swat', 'Bendy', 'Daddy', 'Eyeballs',
              'Crazy Eyes', 'Wrist', 'Twister', 'Punisher', 'Assassin', 'Piano Man',
              'Ball-breaker', 'Crusher', 'Wet Blanket', 'Whippet', 'Joker', 'Clown',
              'Lumberjack', 'Wizard', 'Shadow', 'One', 'Space Bar', 'Escape Key',
              'Matador', 'Hawk', 'Bear', 'Wolf', 'Fist', 'Wrist-o']

  def update_stats
    update_attributes(games: update_games_count, win_percentage: calculate_win_percentage)
  end

  def update_win_count
    self.wins += 1
  end

  def update_games_count
    self.games += 1
  end

  def calculate_win_percentage
    (wins.to_f/games) * 100
  end

  def new_nickname
    update_attributes(nickname: NICKNAMES.sample)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name_with_nickname
    "#{first_name} 'The #{nickname}' #{last_name}"
  end
end
