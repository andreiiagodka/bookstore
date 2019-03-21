class CouponsController < ApplicationController
  before_action :get_coupon

  def update
    if @coupon
      attach_order unless @coupon.order
    else
      flash[:danger] = t('message.error.coupon.used')
    end

    return redirect_to @page_presenter.previous_url
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code)
  end

  def get_coupon
    @coupon = Coupons::GetActiveCouponService.new(coupon_params).call
  end

  def attach_order
    if Coupons::AttachOrderService.new(@coupon, current_order).call
      flash[:success] = t('message.success.coupon.use')
    else
      flash[:danger] = @coupon.errors.full_messages.to_sentence
    end
  end
end
