describe Match do

  before(:each) do
    @match = FactoryGirl.create(:match)
  end

  it { should belong_to :round }

  it { should belong_to :player_one }

  it { should belong_to :player_two }

end
