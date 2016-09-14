describe Player do

  before(:each) {
    @player = FactoryGirl.create(:player)
  }

  subject { @player }

  it { should respond_to(:name) }

  it { should belong_to(:user) }

  it { should have_many(:tournaments) }

  it { should have_many(:tournaments).through(:players_tournaments) }

  describe '#update_win_count' do
    it 'updates the win count' do
      expect{@player.update_win_count}.to change{@player.wins}.by 1
    end
  end

  describe '#update_games_count' do
    it 'updates the games count' do
      expect{@player.update_games_count}.to change{@player.games}.by 1
    end
  end

  describe '#calculate_win_percentage' do
    it 'calucaltes the win percentage' do
      player = FactoryGirl.create(:player, wins: 2, games: 4)
      expect(player.calculate_win_percentage).to eq 50
    end
  end

  describe '#update_stats' do
    it 'updates the games count and win_percentage for a player' do
      player = FactoryGirl.create(:player, wins: 2, games: 4, win_percentage: 50)
      player.update_stats
      expect(player.games).to eq 5
      expect(player.win_percentage).to eq 40
    end
  end
end
