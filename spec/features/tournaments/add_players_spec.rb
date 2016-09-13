feature 'Adding Players', :omniauth, :new_tournament do

  scenario 'Adding players' do
    add_four_players
    within('.players_list') { expect(page).to have_content 'Sean' }
    within('.players_list') { expect(page).to have_content 'Sina' }
    within('.players_list') { expect(page).to have_content 'Brad' }
    within('.players_list') { expect(page).to have_content 'Chris' }
  end

end
