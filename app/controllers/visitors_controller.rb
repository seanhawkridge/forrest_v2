class VisitorsController < ApplicationController

  def index
    @matches = Match.with_results.limit(3)
    @players = Player.by_points.limit(4)
  end

end
