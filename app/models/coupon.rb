class Coupon < ApplicationRecord
  include AASM

  belongs_to :order, optional: true

  validates :order_id, uniqueness: true, allow_nil: true

  scope :active,   -> { where status: 'active' }
  scope :inactive, -> { where status: 'inactive' }


  aasm :status, column: :status do
    state :active, initial: true
    state :inactive

    event :deactivate do
      transitions to: :inactive
    end
  end
end
