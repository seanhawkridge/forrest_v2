FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    image Faker::Avatar.image
    provider "google"
    uid "12345"
  end
end
