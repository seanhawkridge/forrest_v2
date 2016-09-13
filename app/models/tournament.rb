class Tournament < ApplicationRecord

  has_many :players_tournaments
  has_many :players, through: :players_tournaments
  has_many :rounds

  def build_tournament
    create_first_round
  end

  private

  def create_first_round
    pairings = create_pairings(players)
    first_round = rounds.create
    first_round_matches = pairings.map do |pairing|
      first_round.create_match(pairing[0], pairing[1])
    end
    first_round.save
    rounds << first_round
  end

  def create_pairings(collection)
    collection.each_slice(2).to_a
  end
end
