feature 'Viewing Players' do

  before do
    @players = FactoryGirl.create_list(:player, 2)
  end

  scenario 'viewing a list of players with statistics' do
    visit root_path
    click_link 'Players'
    expect(page).to have_content @players[0].name
    expect(page).to have_content @players[0].games
    expect(page).to have_content @players[0].wins
    expect(page).to have_content @players[0].win_percentage
    expect(page).to have_content @players[1].name
    expect(page).to have_content @players[1].games
    expect(page).to have_content @players[1].wins
    expect(page).to have_content @players[1].win_percentage
  end

end
