class Book < ApplicationRecord
  has_one_attached :cover
  has_many_attached :images

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :reviews, dependent: :destroy
  has_many :order_books, dependent: :destroy
  has_many :orders, through: :order_books

  scope :by_filter, -> (filter) { public_send(filter) }

  scope :created_at_desc, -> { order('created_at desc') }
  scope :popularity_desc, -> { order('created_at desc') }
  scope :name_asc, -> { order('name') }
  scope :name_desc, -> { order('name desc') }
  scope :price_asc, -> { order('price') }
  scope :price_desc, -> { order('price desc') }
end
