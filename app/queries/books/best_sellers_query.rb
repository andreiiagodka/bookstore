class Books::BestSellersQuery
  BEST_SELLERS_QUANTITY = 4

  def self.call
    Book.all.sample(BEST_SELLERS_QUANTITY)
  end
end
