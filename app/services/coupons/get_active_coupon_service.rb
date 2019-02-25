class Coupons::GetActiveCouponService
  def initialize(code)
    @code = code
  end

  def call
    Coupon.active.find_by(code: @code)
  end
end
