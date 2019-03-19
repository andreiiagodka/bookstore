class Orders::AttachUserService
  def initialize(order, user)
    @order = order
    @user = user
  end

  def call
    @order.update(user: @user)
  end
end
