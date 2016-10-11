class PlayersController < ApplicationController

  def index
    @players = Player.by_win_percantage
  end
end
