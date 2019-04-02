FactoryBot.define do
  factory :credit_card do
    number { Faker::Number.number(16) }
    name { Faker::Name.name }
    expire_date { "#{Faker::Number.between(1, 12)}/#{Faker::Number.between(1, 12)}" }
    cvv { Faker::Number.number(3) }
  end
end
