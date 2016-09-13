describe Round do

  before(:each) do
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
end
