class Books::GetCategoryBooksService
  include Filtering

  def initialize(books, params)
    @books = books
    @filter = params[:filter]
    @category_id = params[:category_id]
  end

  def call
    books = @category_id ? Category.find_by(id: @category_id).books : @books
    books.public_send(get_filter)
  end

  private

  def get_filter
    BOOK_FILTERING_ORDER.include?(@filter&.to_sym) ? @filter : DEFAULT_BOOK_FILTERING_ORDER
  end
end
