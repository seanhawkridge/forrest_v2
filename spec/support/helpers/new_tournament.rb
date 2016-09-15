module NewTournament

  def create_tournament
    visit root_path
    click_link 'New Tournament'
    fill_in 'Name', with: 'Test Tournament'
    click_button 'Create Tournament'
  end

  def add_four_players
    FactoryGirl.create(:player, name: 'Sean')
    FactoryGirl.create(:player, name: 'Sina')
    FactoryGirl.create(:player, name: 'Brad')
    FactoryGirl.create(:player, name: 'Chris')
    signin
    create_tournament
    select 'Sean', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Sina', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Brad', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Chris', from: 'tournament[players]'
    click_button 'Add to tournament'
  end

  def add_five_players
    FactoryGirl.create(:player, name: 'Sean')
    FactoryGirl.create(:player, name: 'Sina')
    FactoryGirl.create(:player, name: 'Brad')
    FactoryGirl.create(:player, name: 'Chris')
    FactoryGirl.create(:player, name: 'Dwain')
    signin
    create_tournament
    select 'Sean', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Sina', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Brad', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Chris', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Dwain', from: 'tournament[players]'
    click_button 'Add to tournament'
  end

end
