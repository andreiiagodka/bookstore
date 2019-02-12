class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  SCORE = (1..5).freeze

  validates :title,
            presence: true,
            length: { maximum: 80 }

  validates :body,
            presence: true,
            length: { maximum: 500 }
end
