class CouponsController < ApplicationController
  before_action :get_coupon

  def update
    @coupon ? attach_order_to_coupon : flash[:danger] = t('message.error.coupon.used')

    return redirect_to @page_presenter.previous_url
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :order_id)
  end

  def get_coupon
    @coupon = Coupons::GetActiveCouponService.new(coupon_params[:code]).call
  end

  def attach_order_to_coupon
    if @coupon.update(order_id: get_order.id)
      flash[:success] = t('message.success.coupon.use')
    else
      flash[:danger] = @coupon.errors.full_messages.to_sentence
    end
    Coupons::DeactivateCouponService.new(@acoupon).call
  end

  def get_order
    @order = Order.find_by(id: coupon_params[:order_id])
  end
end
