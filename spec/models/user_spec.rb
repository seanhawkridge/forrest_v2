describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:name) }

  it { should respond_to(:email) }

  it { should respond_to(:image) }

  describe '#create_player' do
    it 'creates a new player when a user is created' do
      user = FactoryGirl.create(:user)
      expect(Player.first.user_id).to eq @user.id
    end
  end
end
