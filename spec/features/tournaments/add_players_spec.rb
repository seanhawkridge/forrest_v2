feature 'Adding Players', :omniauth, :new_tournament do

  scenario 'Adding players' do
    signin
    add_four_players
    within('.players-list') { expect(page).to have_content 'Sean' }
    within('.players-list') { expect(page).to have_content 'Sina' }
    within('.players-list') { expect(page).to have_content 'Brad' }
    within('.players-list') { expect(page).to have_content 'Chris' }
  end

end
