class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true

  has_one :coupon, dependent: :destroy
  has_one :delivery, dependent: :destroy

  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books
  has_many :order_addresses, dependent: :destroy
  has_many :addresses, through: :order_addresses

  enum status: {
    in_progress: 0,
    in_queue: 1,
    in_delivery: 2,
    delivered: 3,
    canceled: 4
  }

  aasm :status, column: :status, enum: true do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled
  end
end
