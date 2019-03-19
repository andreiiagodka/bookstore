class Orders::ClearCurrentOrderSessionService
  def initialize(session)
    @session = session
  end

  def call
    @session.delete(:order_id)
  end
end
