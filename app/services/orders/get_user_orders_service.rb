class Orders::GetUserOrdersService
  include Filtering

  def initialize(user, params)
    @user = user
    @filter = params[:filter]
  end

  def call
    @user.orders.public_send(define_filter)
  end

  private

  def define_filter
    ORDER_FILTERING_ORDER.include?(@filter&.to_sym) ? @filter : DEFAULT_ORDER_FILTERING_ORDER
  end
end
