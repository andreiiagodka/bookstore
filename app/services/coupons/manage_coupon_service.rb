class Coupons::ManageCouponService
  def initialize(order, params)
    @order = order
    @coupon = get_active_coupon(params)
  end

  def apply
    return if @order.coupon || !@coupon

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
