class Orders::FilteringService
  include Filtering

  def initialize(filter)
    @filter = filter
  end

  def call
    ORDER_FILTERING_ORDER.include?(@filter&.to_sym) ? @filter : DEFAULT_ORDER_FILTERING_ORDER
  end
end
