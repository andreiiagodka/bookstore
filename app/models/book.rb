class Book < ApplicationRecord
  has_one_attached :cover

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories

  def cover_w160
    return self.cover.variant(resize: '160').processed
  end

  def cover_w250_h310
    return self.cover.variant(resize: '250x310').processed
  end
end
