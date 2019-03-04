class Address < ApplicationRecord
  has_many :user_addresses, dependent: :destroy
  has_many :user, through: :user_addresses

  enum type: %i[billing shipping]
end
