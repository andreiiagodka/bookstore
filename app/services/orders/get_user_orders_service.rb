class Orders::GetUserOrdersService
  include Filtering

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    @user.orders.public_send(get_filter)
  end

  private

  def get_filter
    ORDER_FILTERING_ORDER.include?(@params[:filter]&.to_sym) ? @params[:filter] : DEFAULT_ORDER_FILTERING_ORDER
  end
end
