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
    completed: 1,
    canceled: 2,
    in_delivery: 3,
    delivered: 4
  }

  aasm :status, column: :status, enum: true do
    state :in_progress, initial: true
    state :completed
    state :canceled
    state :in_delivery
    state :delivered

    event :complete do
      transitions from: :in_progress, to: :completed
    end
  end
end
