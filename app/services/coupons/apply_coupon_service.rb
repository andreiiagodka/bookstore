class Coupons::ApplyCouponService
  def initialize(order, params)
    @order = order
    @coupon = get_active_coupon(params)
  end

  def call
    return unless @coupon

    apply_coupon
    deactivate_coupon
  end

  private

  def get_active_coupon(params)
    Coupon.active.find_by(code: params[:code])
  end

  def apply_coupon
    @order.update(coupon: @coupon)
  end

  def deactivate_coupon
    @coupon.update(active: false)
  end
end
