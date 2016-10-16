class Tournament < ApplicationRecord

  has_many :players_tournaments
  has_many :players, through: :players_tournaments
  has_many :rounds
  belongs_to :champion, class_name: 'Player', optional: true

  scope :incomplete, -> { where(champion_id: nil) }
  scope :complete, -> { where.not(champion_id: nil) }

  def build_tournament
    create_first_round
    create_remaining_rounds
    update_byes
  end

  def create_first_round
    seeded_players = matchups(players_and_byes).flatten
    pairings = create_pairings(seeded_players)
    first_round = rounds.create
    first_round_matches = pairings.map do |pairing|
      first_round.create_match(pairing[0], pairing[1])
    end
    first_round.number = 1
    first_round.save
    rounds << first_round
  end

  def create_remaining_rounds
    count = rounds.first.matches.size
    round_number = 2
    while count >= 2
      count /= 2
      next_round = rounds.create
      count.times { next_round.matches << next_round.matches.create }
      next_round.number = round_number
      next_round.save
      rounds << next_round
      round_number += 1
    end
  end

  def process_results(round)
    round = rounds.find(round)
    round.is_final? ? set_champion(round) : update_next_round(round)
  end

  def set_champion(round)
    update_attributes(champion: round.final_winner)
    notify_slack
  end

  def notify_slack
    notifier = Slack::Notifier.new ENV["WEBHOOK_URL"]
    notifier.ping slack_message
  end

  def slack_message
    ":trophy: " +
    "#{champion.name} just won the #{self.name} tournament! What a legend."
  end

  def update_next_round(round)
    pairings = create_pairings(round.collect_winners)
    binding.pry
    p ""
    next_round = rounds.find(round.id+1)
    next_round.matches.order_by_id.each.with_index do |match, i|
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
    players_and_byes = []
    players_and_byes << players.sort_by(&:points).reverse
    players_and_byes << byes_array
    players_and_byes.flatten
  end

  def update_byes
    rounds.first.update_byes
    update_next_round(rounds.first) unless rounds.first.is_final?
  end

  def matchups(players)
    return players if players.count == 1
    s1, s2 = (players).each_slice(players.count/2).to_a
    matchups(s1.zip(s2.reverse));
  end

  def match_order matchups
    a, b = half_slice(matchups)
    a.rotate(1).reverse.zip(b.rotate(3))
  end

  def half_slice collection
    collection.each_slice(collection.count/2).to_a
  end

end
