class Coupons::GetActiveCouponService
  def initialize(params)
    @params = params
  end

  def call
    Coupon.active.find_by(code: @params[:code])
  end
end
