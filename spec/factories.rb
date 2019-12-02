FactoryBot.define do
  factory :card do
    name       { Faker::Name.name }
    set        { Faker::Internet.email }
    image_url  { Faker::PhoneNumber.phone_number }
  end

  factory :user do
    email       { Faker::Internet.email }
    password    { Faker::PhoneNumber.phone_number }
  end
end
