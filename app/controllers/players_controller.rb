class PlayersController < ApplicationController

  def index
    @players = Player.order(win_percentage: :desc).order(games: :desc)
  end
end
