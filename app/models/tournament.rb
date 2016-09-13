class Tournament < ApplicationRecord

  has_many :players_tournaments
  has_many :players, through: :players_tournaments
  has_many :rounds

  def build_tournament
    create_first_round
    create_remaining_rounds
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

  def create_remaining_rounds
    count = rounds.first.matches.size
    while count >= 2
      count /= 2
      next_round = rounds.create
      count.times do
        match = next_round.matches.create
        next_round.matches << match
      end
      rounds << next_round
    end
  end

  def create_pairings(collection)
    collection.each_slice(2).to_a
  end
end
