feature 'Starting a tournament' do

  before(:each) do
    signin
  end

  scenario 'with a first round of players' do
    create_tournament
    add_four_players
    click_button 'Generate Matches'
    expect(page).to have_no_css('#tournament_players')
    expect(page).to have_no_css('#generate_matches')
    expect(page).to have_content('Round 1')
    expect(page).to have_content('Sean')
    expect(page).to have_content('Sina')
    expect(page).to have_content('Final')
    expect(page).to have_content('Brad')
    expect(page).to have_content('Chris')
  end

  scenario 'with a prepared second round' do
    create_tournament
    add_four_players
    click_button 'Generate Matches'
    expect(page).to have_content('Final')
    expect(page).to have_content('player')
    expect(page).to have_content('player')
  end

  scenario 'with byes' do
    create_tournament
    add_five_players
    click_button 'Generate Matches'
    expect(page).to have_content('Round 1')
    expect(page).to have_content('Sean')
    expect(page).to have_content('bye')
    expect(page).to have_content('Winner: Sean')
    expect(page).to have_content('Sina')
    expect(page).to have_content('bye')
    expect(page).to have_content('Winner: Sina')
    expect(page).to have_content('Final')
    expect(page).to have_content('Sean')
    expect(page).to have_content('Sina')
  end

end
