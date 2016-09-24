class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    @match.save
    redirect_to @match
  end

  def index
    @matches = Match.all
  end

  def show
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    @match.update_results(params[:match][:player_one_score], params[:match][:player_two_score])
    if params[:match][:tournament_id]
      @tournament = Tournament.find(params[:match][:tournament_id])
      @tournament.process_results(@match.round_id)
      redirect_to @tournament
    else
      redirect_to @match
    end
  end

  def match_params
    params.require(:match).permit(:player_one_id, :player_two_id, :round_id,
                                  :player_one_score, :player_two_score, :winner,
                                  :bye)
  end
end
