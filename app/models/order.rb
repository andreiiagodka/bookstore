class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true

  has_one :coupon, dependent: :destroy
  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books

  scope :in_progress, -> { where status: 'in_progress' }
  scope :in_queue,    -> { where status: 'in_queue' }
  scope :in_delivery, -> { where status: 'in_delivery' }
  scope :delivered,   -> { where status: 'delivered' }
  scope :canceled,    -> { where status: 'canceled' }

  aasm :status, column: :status do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled
  end
end
