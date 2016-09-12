describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:name) }

  it { should respond_to(:email) }

  it { should respond_to(:image) }

end
