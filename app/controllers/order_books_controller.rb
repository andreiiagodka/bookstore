class OrderBooksController < ApplicationController
  load_and_authorize_resource

  before_action :get_order, only: :create

  def create
    order_book = OrderBooks::CreateOrUpdateService.new(@order, order_book_params).call
    if order_book.save
      flash[:success] = t('message.success.order_book.create')
    else
      flash[:danger] = order_book.errors.full_messages.to_sentence
    end

    redirect_to @page_presenter.previous_url
  end

  def update
    OrderBooks::ChangeBookQuantityService.new(@order_book, params[:quantity_action]).call

    redirect_to @page_presenter.previous_url
  end

  def destroy
    if @order_book.destroy
      flash[:success] = t('message.success.order_book.delete')
    else
      flash[:danger] = @order_book.errors.full_messages.to_sentence
    end

    redirect_to @page_presenter.previous_url
  end

  private

  def order_book_params
    params.require(:order_book).permit(:quantity, :book_id)
  end

  def get_order
    @order ||= current_order
  end
end
