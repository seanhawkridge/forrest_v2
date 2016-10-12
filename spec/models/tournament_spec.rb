describe Tournament do

  before(:each) { @tournament = FactoryGirl.create(:tournament) }

  subject { @tournament }

  it { should respond_to(:name) }

  it { should have_many(:players) }

  it { should have_many(:players).through(:players_tournaments) }

  it { should belong_to(:champion) }


  describe '#build_tournament' do

    it 'creates a first round' do
      players = FactoryGirl.create_list(:player, 4)
      @tournament.players << players
      expect(@tournament.rounds).to be_empty
      @tournament.build_tournament
      expect(@tournament.rounds.first).to be_a Round
    end

    it 'creates a round with the correct number of matches' do
      players = FactoryGirl.create_list(:player, 4)
      @tournament.players << players
      @tournament.build_tournament
      expect(@tournament.rounds.first.matches.count).to eq 2
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

  describe '#byes_array' do

    it 'generates an array of symbols whose legnth make up a power of two
        when added to the player count' do
      players = FactoryGirl.create_list(:player, 5)
      @tournament.players << players
      expect(@tournament.byes_array).to eq [:bye, :bye, :bye]
    end

  end

  describe '#players_and_byes' do

    it 'returns an array of alternating players and byes whose size is a power of 2' do
      players = FactoryGirl.create_list(:player, 5)
      @tournament.players << players
      @tournament.byes_array
      expect(@tournament.players_and_byes).to eq [players[0], players[1], players[2], players[3], players[4], :bye, :bye, :bye]
    end

  end

end
