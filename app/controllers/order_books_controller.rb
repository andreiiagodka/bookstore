class OrderBooksController < ApplicationController
  load_and_authorize_resource

  before_action :initialize_current_order_session, only: :create

  def create
    if OrderBooks::CreateService.new(current_order, order_book_params).call
      flash[:success] = t('message.success.order_book.create')
    else
      flash[:danger] = @order_book.errors.full_messages.to_sentence
    end

    redirect_to @page_presenter.previous_url
  end

  def update
    OrderBooks::UpdateQuantityService.new(@order_book, params[:quantity_action]).call

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

  def initialize_current_order_session
    Orders::InitializeCurrentOrderSessionService.new(current_user, session).call unless current_order
  end
end
