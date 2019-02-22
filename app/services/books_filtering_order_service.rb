class BooksFilteringOrderService
  DEFAULT_BOOK_ORDER_FILTER = :created_at_desc

  BOOK_ORDER_FILTERS = {
    created_at_desc: 'Newest first',
    popularity_desc: 'Popular first',
    name_asc: 'Title A-Z',
    name_desc: 'Title Z-A',
    price_asc: 'Price: Low to high',
    price_desc: 'Price: High to low'
  }.freeze

  def initialize(filter)
    @filter = filter
  end

  def call
    BOOK_ORDER_FILTERS.include?(@filter&.to_sym) ? @filter : DEFAULT_BOOK_ORDER_FILTER
  end
end
