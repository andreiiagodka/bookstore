class Coupons::DeactivateService
  def initialize(coupon)
    @coupon = coupon
  end

  def call
    @coupon.update(active: false)
  end
end
