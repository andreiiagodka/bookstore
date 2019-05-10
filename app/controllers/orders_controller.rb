class OrdersController < ApplicationController
  load_resource only: :show
  authorize_resource

  ORDERS_PER_PAGE = 10

  include Filtering
  include Pagy::Backend

  decorates_assigned :order

  def index
    @pagy, @orders = pagy(current_user.orders.public_send(get_filter), items: ORDERS_PER_PAGE)
  end

  def show; end

  private

  def get_filter
    @filter = ORDER_FILTERING_ORDER.include?(params[:filter]&.to_sym) ? params[:filter] : DEFAULT_ORDER_FILTERING_ORDER
  end
end
