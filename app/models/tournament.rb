class Tournament < ApplicationRecord

  has_many :players_tournaments
  has_many :players, through: :players_tournaments
  has_many :rounds
  belongs_to :champion, class_name: 'Player', optional: true

  def build_tournament
    create_first_round
    create_remaining_rounds
    update_byes
  end

  def create_first_round
    pairings = create_pairings(players_and_byes)
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
      count.times { next_round.matches << next_round.matches.create }
      next_round.save
      rounds << next_round
    end
  end

  def process_results(round)
    round = rounds.find(round)
    round.is_final? ? set_champion(round) : update_next_round(round)
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

  def byes_array
    byes_array = []
    byes_count.times { byes_array << :bye }
    byes_array
  end

  def byes_count
    player_count = players.size
    tournament_size = powers_array.find { |x| x >= player_count }
    byes_count = tournament_size - player_count
  end

  def powers_array
    powers_array = []
    2.upto(10) { |p| powers_array << 2**(p-1) }
    powers_array
  end

  def players_and_byes
    players.zip(byes_array).flatten.compact
  end

  def update_byes
    rounds.first.update_byes
    update_next_round(rounds.first) unless rounds.first.is_final?
  end

end
