require 'faker'

30.times { Author.create(name: Faker::Book.author) }

3.times { Category.create(name: Faker::Book.genre) }

17.times {
  book = Book.create(
    name: Faker::Book.title,
    price: Faker::Number.decimal(2),
    description: Faker::Lorem.paragraph_by_chars(256, false),
    publication_year: Faker::Number.between(2000, Time.now.year),
    height: Faker::Number.decimal(2),
    width: Faker::Number.decimal(2),
    depth: Faker::Number.decimal(2),
    material: Faker::Science.element
  )
  book.authors << Author.all.shuffle.first(rand(1..3))
  book.categories << Category.all.shuffle.first
  cover = "#{rand(1..17)}.jpg";
  book.cover.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', 'covers', cover)),
    filename: cover
  )
}
