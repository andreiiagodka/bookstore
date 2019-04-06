FactoryBot.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    country { Faker::Address.country_code }
    city { Faker::Address.city.split.first }
    address { Faker::Address.street_name }
    zip { Faker::Number.number(5).to_i }
    phone { '+380' + Faker::Number.number(11) }

    trait :billing do
      cast { Address.casts[:billing] }
    end

    trait :shipping do
      cast { Address.casts[:shipping] }
    end
  end
end
