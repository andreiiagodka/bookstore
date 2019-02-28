class Coupon < ApplicationRecord
  include AASM

  belongs_to :order, optional: true

  validates :order_id, uniqueness: true, allow_nil: true

  scope :active,   -> { where active: true }
  scope :inactive, -> { where active: false }
end
