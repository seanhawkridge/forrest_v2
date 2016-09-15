feature 'Starting a tournament' do

  scenario 'with a first round of players' do
    create_tournament
    add_four_players
    click_button 'Generate Matches'
    expect(page).to have_no_css('#tournament_players')
    expect(page).to have_no_css('#generate_matches')
    expect(page).to have_content('Round 1')
    expect(page).to have_content('Match 1')
    expect(page).to have_content('p1: Sean')
    expect(page).to have_content('p2: Sina')
    expect(page).to have_content('Match 2')
    expect(page).to have_content('p1: Brad')
    expect(page).to have_content('p2: Chris')
  end

  scenario 'with a prepared second round' do
    create_tournament
    add_four_players
    click_button 'Generate Matches'
    expect(page).to have_content('Round 2')
    expect(page).to have_content('Match 1')
    expect(page).to have_content('p1: player')
    expect(page).to have_content('p2: player')
  end

  scenario 'with byes' do
    create_tournament
    add_five_players
    click_button 'Generate Matches'
    expect(page).to have_content('Round 1')
    expect(page).to have_content('p1: Sean')
    expect(page).to have_content('p2: bye')
    expect(page).to have_content('Winner: Sean')
    expect(page).to have_content('Match 2')
    expect(page).to have_content('p1: Sina')
    expect(page).to have_content('p2: bye')
    expect(page).to have_content('Winner: Sina')
    expect(page).to have_content('Round 2')
    expect(page).to have_content('Match 1')
    expect(page).to have_content('p1: Sean')
    expect(page).to have_content('p2: Sina')
  end

end
