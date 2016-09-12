describe Tournament do

  before(:each) { @tournament = FactoryGirl.create(:tournament) }

  subject { @tournament }

  it { should respond_to(:name) }

end
