feature 'Starting a tournament' do

  scenario 'with a full round of players' do
    create_tournament
    add_players
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

end
