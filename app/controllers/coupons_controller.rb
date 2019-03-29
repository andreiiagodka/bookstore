class CouponsController < ApplicationController
  def update
    if Coupons::ApplyCouponService.new(current_order, coupon_params).call
      flash[:success] = t('message.success.coupon.use')
    else
      flash[:danger] = t('message.error.coupon.used')
    end

    redirect_to @page_presenter.previous_url and return
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
