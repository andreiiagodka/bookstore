class Books::GetCategoryBooksService
  include Filtering

  def initialize(books, params)
    @books = books
    @params = params
  end

  def call
    books = @category_id ? Category.find_by(id: @params[:category_id]).books : @books
    books.public_send(get_filter)
  end

  private

  def get_filter
    BOOK_FILTERING_ORDER.include?(@params[:filter]&.to_sym) ? @params[:filter] : DEFAULT_BOOK_FILTERING_ORDER
  end
end
