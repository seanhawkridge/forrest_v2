class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def create
    player_one = Player.find(params[:player_one])
    player_two = Player.find(params[:player_two])
    if player_one == player_two
      redirect_to new_match_path,
                  alert: "No playing with yourself #{player_one.first_name}"
    else
      [player_one, player_two].each { |player| player.new_nickname }
      @match = Match.new(player_one: player_one, player_two: player_two)
      @match.save
      redirect_to @match
    end
  end

  def index
    @matches = Match.with_results
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
    params.require(:match).permit(:player_one_id, :player_two_id, :player_one_nickname, :player_two_nickname, :round_id,
                                  :player_one_score, :player_two_score, :winner,
                                  :bye)
  end
end
