class PlayersController < ApplicationController

  def index
    @players = Player.position
    if user_signed_in?
      @current_player = current_user.player
      @challengeable = @players.ladder_challengeable(@current_player)
    end
  end

end
