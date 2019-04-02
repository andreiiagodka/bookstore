FactoryBot.define do
  factory :order do
    number { Orders::GenerateNumberService.new.call }
    delivery
    credit_card
  end

  trait :attach_book do
    after(:create) do |order|
      create(:order_book, order: order)
    end
  end
end
