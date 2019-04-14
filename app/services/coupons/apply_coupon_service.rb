class Coupons::ApplyCouponService
  def initialize(order, params)
    @order = order
    @coupon = Coupons::GetActiveCouponByCodeService.new(params).call
  end

  def call
    return false unless @coupon

    @order.update(coupon: @coupon)
    Coupons::DeactivateService.new(@coupon).call
  end
end
