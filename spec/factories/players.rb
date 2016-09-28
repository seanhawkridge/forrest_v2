FactoryGirl.define do
  factory :player do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    games { Faker::Number.between(5, 10) }
    wins { Faker::Number.between(0, 5) }
    association :user
  end
end
