class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  scope :active,   -> { where active: true }
  scope :inactive, -> { where active: false }

  validates :order_id, uniqueness: true, allow_nil: true
end
