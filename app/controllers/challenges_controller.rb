class ChallengesController < ApplicationController

  before_action :authenticate_user!

  def new
    @challenge = Challenge.new
  end

  def index
    @challenges = Challenge.all
  end

  def create
    players = [Player.find(params[:challenger]), Player.find(params[:challenged])]
    if players[0].free_to_challenge?
      @challenge = Challenge.create challenger: players[0], challenged: players[1], status: "open"
      ChallengeNotifier.challenge_invitation_notification challenge: @challenge, url: url_for(@challenge)
      redirect_to @challenge
    else
      redirect_to players_path, alert: "You already have an open challenge"
    end
  end

  def update
    @challenge = Challenge.find(params[:id])
    refused_challenge if params[:status] == "refused"
    cancelled_challenge if params[:status] == "cancelled"
  end

  def show
    @challenge = Challenge.find(params[:id])
    @challenge_match = Match.with_challenge(@challenge.id).first
  end

  private

  def refused_challenge
    @challenge.update status: "refused"
    redirect_to players_path, alert: "Challenge refused."
  end

  def cancelled_challenge
    @challenge.update status: "cancelled"
    redirect_to players_path, alert: "Challenge cancelled."
  end

  def challenge_params
    params.require(:challenge).permit(:challenger, :challenged, :status, :result)
  end

end
