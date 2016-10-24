
class MatchesController < ApplicationController

  def new
    @current_player = current_user.player
    @players = Player.ladder_challengeable(@current_player)
  end

  def create
    @match = Match.create(player_one: Player.find(params[:player_one]), player_two: Player.find(params[:player_two]))
    create_challenge_match if params[:match_type] == "challenge"
    redirect_to @match
  end

  def index
    @matches = Match.with_results
  end

  def show
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.winner
      redirect_to @match, alert: "A result has already been logged for this match"
    else
      @match.update_results(params[:match][:player_one_score], params[:match][:player_two_score])
      params[:match][:tournament_id] ? update_tournament_match : update_challenge_match
    end
  end

  private

  def match_params
    params.require(:match).permit(:player_one_id, :player_two_id, :round_id,
                                  :player_one_score, :player_two_score, :winner,
                                  :bye, :match_type, :challenge)
  end

  def create_challenge_match
    @challenge = Challenge.find(params[:challenge])
    @match.update challenge: @challenge, match_type: "challenge"
    @match.challenge.update status: "accepted"
    ChallengeNotifier.challenge_accepted_notification match: @match, url: (url_for @match)
  end

  def update_challenge_match
      @match.update_positions
      @match.challenge.update status: "complete"
      MatchNotifier.challenge_result_notification @match
      redirect_to @match
  end

  def update_tournament_match
    @tournament = Tournament.find(params[:match][:tournament_id])
    @tournament.process_results @match.round_id
    MatchNotifier.tournament_result_notification @match
    redirect_to @tournament
  end
end
