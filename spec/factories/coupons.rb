FactoryBot.define do
  factory :coupon do
    code { Faker::Number.between(1, 10).to_s * 4 }
    discount_percent { 10 }
    active { true }
  end
end
