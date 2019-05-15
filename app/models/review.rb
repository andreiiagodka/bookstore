class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :published,   -> { where published: true }
  scope :unpublished, -> { where published: false }
end
