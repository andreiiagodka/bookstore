class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true

  has_one :coupon, dependent: :destroy

  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books
  has_many :addresses, as: :addressable, dependent: :destroy

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
