module NewTournament

  def create_tournament
    visit root_path
    click_link 'New Tournament'
    fill_in 'Name', with: 'Test Tournament'
    click_button 'Create Tournament'
  end

  def add_players
    FactoryGirl.create(:player, name: 'Sean')
    FactoryGirl.create(:player, name: 'Sina')
    FactoryGirl.create(:player, name: 'Brad')
    FactoryGirl.create(:player, name: 'Chris')
    signin
    create_tournament
    select 'Sean', from: 'tournament[players]'
    click_button 'Add to tournament'
    within('.players_list') { expect(page).to have_content 'Sean' }
    select 'Sina', from: 'tournament[players]'
    click_button 'Add to tournament'
    within('.players_list') { expect(page).to have_content 'Sina' }
    select 'Brad', from: 'tournament[players]'
    click_button 'Add to tournament'
    within('.players_list') { expect(page).to have_content 'Brad' }
    select 'Chris', from: 'tournament[players]'
    click_button 'Add to tournament'
    within('.players_list') { expect(page).to have_content 'Chris' }
  end

end
