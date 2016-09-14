class Match < ApplicationRecord

  belongs_to :player_one, class_name: 'Player', optional: true
  belongs_to :player_two, class_name: 'Player', optional: true
  belongs_to :winner, class_name: 'Player', optional: true
  belongs_to :round

  def update_results(p1_score, p2_score)
    results = calculate_results(p1_score, p2_score)
    results[:winner].update_win_count
    results.each { |position, player| player.update_stats }
    update_attributes(winner: results[:winner], player_one_score: p1_score, player_two_score: p2_score)
  end

  private

  def calculate_results(p1_score, p2_score)
    p1_score > p2_score ? {winner: player_one, loser: player_two} : {winner: player_two, loser: player_one}
  end
end
