module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:google] = {
        'provider' => 'google',
        'uid' => '1234',
        'info' => {
          'first_name' => "Sean",
          'last_name' => "Hawkridge"
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      }
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Sign in")
      auth_mock
      click_link "Sign in"
      byebug
    end
  end

end
