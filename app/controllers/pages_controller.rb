class PagesController < ApplicationController
  decorates_assigned :latest_books, :best_sellers

  def home
    @latest_books = Books::LatestBooksQuery.call
    @best_sellers = Books::BestSellersQuery.call
  end
end
