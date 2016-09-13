class MatchesController < ApplicationController

  def update
    @match = Match.find(params[:id])
    @match.update_results(params[:match][:player_one_score], params[:match][:player_two_score])
    @tournament = Tournament.find(params[:match][:tournament_id])
    @tournament.process_results(@match.round_id)
    redirect_to(@tournament)
  end
end
