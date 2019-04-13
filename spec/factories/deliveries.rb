FactoryBot.define do
  factory :delivery do
    name { Faker::Lorem.word }
    days { Faker::Number.between(1, 14) }
    price { Faker::Number.decimal(2) }
  end
end
