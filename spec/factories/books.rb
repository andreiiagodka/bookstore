FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    price { Faker::Number.decimal(2) }
    description { Faker::Lorem.paragraph_by_chars(Faker::Number.between(300, 350), false) }
    publication_year { Faker::Number.between(2000, Time.now.year) }
    height { Faker::Number.decimal(2) }
    width { Faker::Number.decimal(2) }
    depth { Faker::Number.decimal(2) }
    material { Faker::Science.element }
  end

  trait :attach_category do
    after(:create) do |book|
      create(:category, books: [book])
    end
  end

  trait :attach_author do
    after(:create) do |book|
      create(:author, books: [book])
    end
  end

  trait :attach_cover do
    after(:create) do |book|
      file_path = Rails.root.join('spec', 'support', 'assets', 'test_cover.jpg')
      file = Rack::Test::UploadedFile.new(file_path, 'image/png')
      book.cover.attach(file)
    end
  end
end
