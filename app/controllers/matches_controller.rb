class MatchesController < ApplicationController

  def create
    @match = Match.new(tournament_params)
    @match.save
  end
  
  def update
    @match = Match.find(params[:id])
    @match.update_results(params[:match][:player_one_score], params[:match][:player_two_score])
    @tournament = Tournament.find(params[:match][:tournament_id])
    @tournament.process_results(@match.round_id)
    redirect_to(@tournament)
  end

  def match_params
    params.require(:match).permit(:player_one_id, :player_two_id, :round_id,
                                  :player_one_score, :player_two_score, :winner,
                                  :bye)
  end
end
