describe Round do

  before do
    @round = FactoryGirl.create(:round)
    @player_one = FactoryGirl.create(:player)
    @player_two = FactoryGirl.create(:player)
  end

  subject { @round }

  it { should belong_to :tournament }

  it { should have_many :matches }

  describe '#create_match' do

    it 'creates a match when passed two players' do
      @round.create_match(@player_one, @player_two)
      expect(@round.matches.first.player_one).to eq @player_one
      expect(@round.matches.first.player_two).to eq @player_two
    end

  end

  describe '#collect_winners' do

    it 'produces an array of the winners of each match in the round' do
      match_one = FactoryGirl.create(:match, winner: @player_one)
      @round.matches << match_one
      expect(@round.collect_winners).to eq [@player_one]
    end

  end

end
