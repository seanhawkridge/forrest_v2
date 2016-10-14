class PlayersController < ApplicationController

  def index
    @players = Player.by_points
    @leader = @players.first
  end
end
