feature 'Adding Players' do

  scenario 'Adding a player', :omniauth do
    user = FactoryGirl.create(:user, name: "Sean")
    FactoryGirl.create(:player, user: user)
    signin
    visit root_path
    click_link 'New Tournament'
    fill_in 'Name', with: 'Test Tournament'
    click_button 'Create Tournament'
    select 'Sean', from: 'tournament[players]'
    click_button 'Add to tournament'
    within('.players_list') { expect(page).to have_content 'Sean' }
  end

end
