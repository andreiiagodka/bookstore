module Filtering
  DEFAULT_BOOK_FILTERING_ORDER = :created_at_desc
  DEFAULT_ORDER_FILTERING_ORDER = :created_at_desc

  BOOK_FILTERING_ORDER = {
    created_at_desc: 'Newest first',
    popularity_desc: 'Popular first',
    name_asc: 'Title A-Z',
    name_desc: 'Title Z-A',
    price_asc: 'Price: Low to high',
    price_desc: 'Price: High to low'
  }.freeze

  ORDER_FILTERING_ORDER = {
    created_at_desc: 'All',
    in_progress: 'In progress',
    completed: 'Waiting for processing',
    in_delivery: 'In delivery',
    delivered: 'Delivered',
    canceled: 'Canceled'
  }.freeze
end
