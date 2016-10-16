class PlayersController < ApplicationController

  def index
    @players = Player.position
    @current_player = current_user.player
    @challengeable = @players.ladder_challengeable(@current_player)
  end

end
