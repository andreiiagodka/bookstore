class Book < ApplicationRecord
  has_one_attached :cover
  has_many_attached :images

  ORDER_FILTERS = {
    created_at_desc: 'Newest first',
    popularity_desc: 'Popular first',
    name_asc: 'Title A-Z',
    name_desc: 'Title Z-A',
    price_asc: 'Price: Low to high',
    price_desc: 'Price: High to low'
  }.freeze
  DEFAULT_ORDER_FILTER = :created_at_desc

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :reviews, dependent: :destroy
  has_many :order_books, dependent: :destroy
  has_many :orders, through: :order_books

  def cover_w160
    return self.cover.variant(resize: '160').processed
  end

  def cover_w250_h310
    return self.cover.variant(resize: '250x310!').processed
  end

  def cover_w555_h380
    return self.cover.variant(resize: '555x380!').processed
  end

  def secondary_image_w171_h120(input)
    return self.images[input].variant(resize: '171x120!').processed
  end

  scope :by_order_filter, -> (order_filter) { public_send(order_filter) }

  scope :created_at_desc, -> { order('created_at desc') }
  scope :popularity_desc, -> { order('created_at desc') }
  scope :name_asc, -> { order('name') }
  scope :name_desc, -> { order('name desc') }
  scope :price_asc, -> { order('price') }
  scope :price_desc, -> { order('price desc') }
end
