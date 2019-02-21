module CurrentOrder
  extend ActiveSupport::Concern

  def get_current_order
    session[:order_id] = create_order.id unless session[:order_id]

    Order.find_by(id: session[:order_id])
  end

  private

  def create_order
    Order.create(user_id: user_signed_in? ? current_user : nil)
  end
end
