FactoryBot.define do
  factory :order do
    number { Orders::GenerateNumberService.new.call }
  end

  trait :attach_book do
    after(:create) do |order|
      create(:order_book, order: order)
    end
  end
end
