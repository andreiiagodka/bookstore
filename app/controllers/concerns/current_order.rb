module CurrentOrder
  extend ActiveSupport::Concern

  def current_order
    session[:order_id] ? find_order(session[:order_id]) : set_session
  end

  private

  def find_order(order_id)
    @current_order ||= Order.find_by(id: order_id).decorate
  end

  def set_session
    session[:order_id] = create_order.id
  end

  def create_order
    Order.create(
      number: Orders::GenerateNumberService.new.call,
      user: set_user
    )
  end

  def set_user
    user_signed_in? ? current_user : nil
  end
end
