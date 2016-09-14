class Tournament < ApplicationRecord

  has_many :players_tournaments
  has_many :players, through: :players_tournaments
  has_many :rounds
  belongs_to :champion, class_name: 'Player', optional: true

  def build_tournament
    create_first_round
    create_remaining_rounds
  end

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

  def process_results(round)
    current_round = rounds.find(round)
    current_round.is_final? ? set_champion(current_round) : update_next_round(current_round)
  end

  def set_champion(round)
    update_attributes(champion: round.final_winner)
  end

  def update_next_round(round)
    pairings = create_pairings(round.collect_winners)
    next_round = rounds.find(round.id+1)
    next_round.matches.each.with_index do |match, i|
      match.update_attributes(player_one: pairings[i][0], player_two: pairings[i][1])
      match.save
    end
    next_round.save
  end

  def create_pairings(collection)
    collection.each_slice(2).to_a
  end
end
