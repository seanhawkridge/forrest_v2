FactoryGirl.define do
  factory :match do
    association(:player_one, factory: :player)
    association(:player_two, factory: :player)
    association(:round)
  end
end
