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

  describe '#is_final?' do

    it 'returns true if the match is the final' do
      match = FactoryGirl.create(:match)
      @round.matches << match
      expect(@round.is_final?).to be true
    end

    it 'returns false if the match is not the final' do
      matches = FactoryGirl.create_list(:match, 2)
      @round.matches << matches
      expect(@round.is_final?).to be false
    end

  end

end
