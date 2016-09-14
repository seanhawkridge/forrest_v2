FactoryGirl.define do
  factory :player do
    name { Faker::Name.name }
    games { Faker::Number.between(5, 10) }
    wins { Faker::Number.between(0, 5) }
    association :user
  end
end
