feature 'New Tournament' do

  scenario 'Creating a new Tournament' do
    visit root_path
    click_link 'New Tournament'
    fill_in('Name', with: 'Test Tournament')
    click_button 'Create Tournament'
    expect(page).to have_content('Test Tournament')
  end

end
