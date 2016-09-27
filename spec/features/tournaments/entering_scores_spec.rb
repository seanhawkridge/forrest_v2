feature 'Entering scores' do

  before(:each) do
    request.env['omniauth.auth'] = auth_mock
    signin
    create_tournament
    add_four_players
    p "USERS=#{User.all.map { |user| user.first_name }}"
    p "PLAYERS=#{Player.all.map { |player| player.first_name }}"
    click_button 'Generate Matches'
  end

  scenario 'scores are logged correctly' do
    first("input[id$='match_player_one_score']").set "3"
    first("input[id$='match_player_two_score']").set "1"
    first("input[type='submit']").click
    expect(Match.first.player_one_score).to eq 3
    expect(Match.first.player_two_score).to eq 1
  end

  scenario 'a winner is calculated' do
    first("input[id$='match_player_one_score']").set "3"
    first("input[id$='match_player_two_score']").set "1"
    first("input[type='submit']").click
    expect(Match.first.winner.name).to eq 'Sean Hawkridge'
  end

  scenario 'the next round is updated' do
    first("input[id$='match_player_one_score']").set "3"
    first("input[id$='match_player_two_score']").set "1"
    first("input[type='submit']").click
    within("#round-2") { expect(page).to have_content('Sean') }
  end

  scenario 'in the final round' do
    p1_inputs = all("input[id$='match_player_one_score']")
    p2_inputs = all("input[id$='match_player_two_score']")
    submits = all("input[type='submit']")
    p1_inputs[0].set "3"
    p2_inputs[0].set "1"
    submits[0].click
    p1_inputs[1].set "1"
    p2_inputs[1].set "2"
    submits[1].click
    p1_inputs[2].set "2"
    p2_inputs[2].set "1"
    submits[2].click
    expect(page).to have_content 'Champion: Sean'
  end

end
