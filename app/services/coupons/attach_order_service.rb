class Coupons::AttachOrderService
  def initialize(coupon, order)
    @coupon = coupon
    @order = order
  end

  def call
    @coupon.update(order: @order)
    Coupons::DeactivateService.new(@coupon).call
  end
end
