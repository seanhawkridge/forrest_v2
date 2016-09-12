class Player < ApplicationRecord

  belongs_to :user
  has_many :players_tournaments
  has_many :tournaments, through: :players_tournaments
end
