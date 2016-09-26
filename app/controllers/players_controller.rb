class PlayersController < ApplicationController

  def index
    @players = Player.by_win_percantage
    @leader = @players.first
  end
end
