FactoryBot.define do
  factory :credit_card do
    name { Faker::Currency.name }
    number { Faker::Number.number(16) }
    expire_date { "12/#{Time.now.year.to_s.last(2)}" }
    cvv { Faker::Number.number(3) }
  end
end
