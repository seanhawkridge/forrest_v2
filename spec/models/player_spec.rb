describe Player do

  before(:each) {
    @user = FactoryGirl.create(:user)
    @player = FactoryGirl.create(:player, user: @user)
  }

  subject { @player }

  it { should respond_to(:name) }

  it { should belong_to(:user) }

  it { should have_many(:tournaments) }

  it { should have_many(:tournaments).through(:players_tournaments) }


end
