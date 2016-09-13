class TournamentsController < ApplicationController

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.save
    redirect_to @tournament
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    @player = Player.find(params[:tournament][:players])
    @tournament.players << @player
    @tournament.save
    redirect_to @tournament
  end

  def build_tournament
    @tournament = Tournament.find(params[:id])
    @tournament.build_tournament
    redirect_to @tournament
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name)
  end
end
