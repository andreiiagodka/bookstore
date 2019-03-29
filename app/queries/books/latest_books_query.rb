class Books::LatestBooksQuery
  LATEST_BOOKS_QUANTITY = 3

  def self.call
    Book.order(created_at: :desc).limit(LATEST_BOOKS_QUANTITY)
  end
end
