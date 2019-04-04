class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true

  has_one :coupon, dependent: :destroy

  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books
  has_many :addresses, as: :addressable, dependent: :destroy

  scope :by_filter, -> (filter) { public_send(filter) }

  scope :created_at_desc, -> { order('created_at desc') }

  enum status: {
    in_progress: 0,
    completed: 1,
    in_delivery: 2,
    delivered: 3,
    canceled: 4
  }

  aasm :status, column: :status, enum: true do
    state :in_progress, initial: true
    state :completed
    state :in_delivery
    state :delivered
    state :canceled

    event :complete do
      transitions from: :in_progress, to: :completed
    end
  end
end
