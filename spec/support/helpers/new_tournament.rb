module NewTournament

  def create_tournament
    visit root_path
    click_link 'New Tournament'
    fill_in 'Name', with: 'Test Tournament'
    click_button 'Build Tournament'
  end

  def add_four_players
    FactoryGirl.create(:player, first_name: 'Sean', last_name: 'Hawkridge')
    FactoryGirl.create(:player, first_name: 'Sina', last_name: 'Zand')
    FactoryGirl.create(:player, first_name: 'Brad', last_name: 'Jennings')
    FactoryGirl.create(:player, first_name: 'Chris', last_name: 'Ward')
    create_tournament
    select 'Sean Hawkridge', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Sina Zand', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Brad Jennings', from: 'tournament[players]'
    click_button 'Add to tournament'
    select 'Chris Ward', from: 'tournament[players]'
    click_button 'Add to tournament'
  end

  def add_five_players
    FactoryGirl.create(:player, first_name: 'Dwain', last_name: 'Faithfull')
    add_four_players
    select 'Dwain Faithfull', from: 'tournament[players]'
    click_button 'Add to tournament'
  end

end
