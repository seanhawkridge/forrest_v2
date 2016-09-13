feature 'New Tournament' do

  scenario 'Creating a new Tournament' do
    create_tournament
    expect(page).to have_content('Test Tournament')
  end

end
