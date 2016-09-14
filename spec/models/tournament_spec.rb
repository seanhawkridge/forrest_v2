describe Tournament do

  before(:each) { @tournament = FactoryGirl.create(:tournament) }

  subject { @tournament }

  it { should respond_to(:name) }

  it { should have_many(:players) }

  it { should have_many(:players).through(:players_tournaments) }

  it { should belong_to(:champion) }


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

  describe '#process_results' do

    it 'adds the winning player for a round to a match in the next round' do
      players = FactoryGirl.create_list(:player, 4)
      @tournament.players << players
      @tournament.build_tournament
      expect_any_instance_of(Match).to receive(:update_attributes)
      @tournament.process_results(@tournament.rounds[0].id)
    end

  end

  describe '#set_champion' do

    xit 'updates the champion for the tournament' do
      players = FactoryGirl.create_list(:player, 2)
      @tournament.players << players
      @tournament.build_tournament
      @tournament.rounds[0].matches[0].winner = players[0]
      @tournament.process_results(@tournament.rounds[0].id)

      expect(@tournament.champion).to be_truthy
    end

  end

end
