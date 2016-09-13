describe Tournament do

  before(:each) { @tournament = FactoryGirl.create(:tournament) }

  subject { @tournament }

  it { should respond_to(:name) }

  it { should have_many(:players) }

  it { should have_many(:players).through(:players_tournaments) }

  describe '#build_tournament' do
    it 'creates a first round' do
      player_one = FactoryGirl.create(:player)
      player_two = FactoryGirl.create(:player)
      @tournament.players << [player_one, player_two]
      @tournament.build_tournament
      expect(@tournament.rounds.first).to be_a Round
    end
  end

end
