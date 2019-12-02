FactoryBot.define do
  factory :card do
    name       { Faker::Name.name }
    set        { Faker::Internet.email }
    image_url  { Faker::PhoneNumber.phone_number }
  end
end
