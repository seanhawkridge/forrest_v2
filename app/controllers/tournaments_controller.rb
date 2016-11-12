class TournamentsController < ApplicationController

  def index
    @completed_tournaments = Tournament.complete
    @incomplete_tournaments = Tournament.incomplete
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.save
    redirect_to @tournament
  end

  def show
    @tournament = Tournament.find(params[:id])
    @rounds = @tournament.rounds.reverse
  end

  def update
    @tournament = Tournament.find(params[:id])
    @player = Player.find(params[:tournament][:players])
    @player.new_nickname
    @tournament.players << @player
    @tournament.save
    redirect_to @tournament
  end

  def build_tournament
    @tournament = Tournament.find(params[:id])
    if @tournament.players.size < 3
      redirect_to @tournament, alert: "You need three players or more to start a tournament."
    else
      @tournament.build_tournament
      redirect_to @tournament
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :champion_id, :champion)
  end
end
