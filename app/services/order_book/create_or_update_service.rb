class OrderBook::CreateOrUpdateService
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    OrderBook.find_or_initialize_by(book_id: get_book.id, order_id: @order.id).tap do |item|
      item.quantity += @params[:quantity].to_i
    end
  end

  private

  def get_book
    @book ||= Book.find_by(id: @params[:book_id])
  end

end
