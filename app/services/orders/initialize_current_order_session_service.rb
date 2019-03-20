class Orders::InitializeCurrentOrderSessionService
  def initialize(user, session)
    @user = user
    @session = session
  end

  def call
    @session[:order_id] = new_order.id
  end

  private

  def new_order
    Order.create(
      number: Orders::GenerateNumberService.new.call,
      user: @user
    )
  end
end
