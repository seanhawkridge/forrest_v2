describe Match do

  before(:each) do
    @match = FactoryGirl.create(:match)
  end

  it { should belong_to :round }

  it { should belong_to :player_one }

  it { should belong_to :player_two }

  it { should belong_to :winner }

  describe '#update_results' do

    it 'should update results when passed a set of scores' do
      @match.update_results(3, 1)
      expect(@match.player_one_score).to eq 3
      expect(@match.player_two_score).to eq 1
    end

    it 'should update the winner when passed a set of scores' do
      @match.update_results(3, 1)
      expect(@match.winner).to eq @match.player_one
    end

    it 'should call the #update_stats method in player' do
      expect(@match.player_one).to receive(:update_stats)
      expect(@match.player_two).to receive(:update_stats)
      @match.update_results(3, 1)
    end

    it 'should call the #update_stats method in player' do
      expect(@match.player_one).to receive(:update_win_count)
      @match.update_results(3, 1)
    end

  end

end
