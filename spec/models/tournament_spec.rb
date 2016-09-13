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
      expect(@tournament.rounds).to be_empty
      @tournament.build_tournament
      expect(@tournament.rounds.first).to be_a Round
    end

    it 'creates following rounds' do
      players = FactoryGirl.create_list(:player, 4)
      @tournament.players << players
      @tournament.build_tournament
      expect(@tournament.rounds.size).to eq 2
      expect(@tournament.rounds.first.matches.size).to eq 2
      expect(@tournament.rounds.last.matches.size).to eq 1
    end
  end

end
