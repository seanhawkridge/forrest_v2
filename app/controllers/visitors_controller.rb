class VisitorsController < ApplicationController

  def index
    @matches = Match.with_results.limit(3)
    @players = Player.position.limit(4)
  end

end
