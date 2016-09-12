class Tournament < ApplicationRecord

  has_many :players_tournaments
  has_many :players, through: :players_tournaments
end
