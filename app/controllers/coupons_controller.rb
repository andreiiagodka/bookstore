class CouponsController < ApplicationController
  before_action :get_coupon
  before_action :get_order

  after_action :count_order_total_price

  def update
    if @coupon
      @coupon.update(order_id: @order.id) ? flash[:success] = t('order.coupon.success_msg')
                                          : flash[:danger] = t('order.coupon.danger_msg')
      @coupon.deactivate!
    end
    return redirect_to @page_presenter.previous_url
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :order_id)
  end

  def get_coupon
    @coupon = Coupon.active.find_by(code: coupon_params[:code])
    flash[:danger] = t('order.coupon.danger_msg') unless @coupon
  end

  def get_order
    @order = Order.find_by(id: coupon_params[:order_id])
  end

  def count_order_total_price
    if @order.coupon
      @order.update(total_price: @order.total_price - (@order.total_price/@order.coupon.discount_percent))
    end
  end
end
