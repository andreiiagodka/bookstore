class Orders::CreateNumberService
  NUMBER_PREFIX = '#R'.freeze
  DATE_FORMAT = '%Y%m%d%H%M%S'.freeze

  def initialize(order)
    @order = order
  end

  def call
    @order.update(number: create_number)
  end

  private

  def create_number
    NUMBER_PREFIX + Time.now.strftime(DATE_FORMAT)
  end
end
