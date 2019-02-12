class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  SCORE = (1..5).freeze
end
