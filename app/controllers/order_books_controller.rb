class OrderBooksController < ApplicationController
  before_action :get_order, only: [:create]
  before_action :get_book, only: [:create]

  decorates_assigned :order

  def create
    order_book = OrderBook.find_or_initialize_by(book_id: @book.id, order_id: @order.id).tap do |item|
      item.quantity += order_book_params[:quantity].to_i
      item.subtotal_price += count_subtotal_price
    end
    order_book.save ? flash[:success] = t('message.success.order_book.create', book_title: @book.name)
                    : flash[:danger] = order_book.errors.full_messages.to_sentence
    redirect_to @page_presenter.previous_url
  end

  def destroy
    OrderBook.find_by(id: params[:id]).destroy ? flash[:success] = t('message.success.order_book.delete', book_title: order_book.book.name)
                                               : flash[:danger] = order_book.errors.full_messages.to_sentence
    redirect_to @page_presenter.previous_url
  end

  private

  def order_book_params
    params.require(:order_book).permit(:quantity, :book_id)
  end

  def get_order
    @order ||= current_order
  end

  def get_book
    @book = Book.find_by(id: order_book_params[:book_id])
  end

  def count_subtotal_price
    @book.price * order_book_params[:quantity].to_i
  end
end
