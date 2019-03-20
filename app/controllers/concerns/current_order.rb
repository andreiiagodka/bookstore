module CurrentOrder
  extend ActiveSupport::Concern

  def current_order
    @current_order ||= get_order if session[:order_id]
  end

  private

  def get_order
    Order.find_by(id: session[:order_id]).decorate
  end
end
