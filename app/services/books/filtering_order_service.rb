class Books::FilteringOrderService
  include FilteringOrder

  def initialize(filter)
    @filter = filter
  end

  def call
    BOOK_FILTERING_ORDER.include?(@filter&.to_sym) ? @filter : DEFAULT_BOOK_FILTERING_ORDER
  end
end
