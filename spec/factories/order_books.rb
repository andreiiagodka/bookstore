FactoryBot.define do
  factory :order_book do
    quantity { Faker::Number.between(3, 5) }
    book
    order
  end
end
