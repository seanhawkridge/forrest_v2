RSpec.configure do |config|
  config.include Omniauth::Mock
  config.include Omniauth::SessionHelpers, type: :feature
  config.include NewTournament, type: :feature
end
OmniAuth.config.test_mode = true
