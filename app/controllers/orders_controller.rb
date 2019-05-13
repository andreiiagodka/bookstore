class OrdersController < ApplicationController
  load_resource only: :show
  authorize_resource

  ORDERS_PER_PAGE = 10

  include Pagy::Backend

  decorates_assigned :order

  def index
    @pagy, @orders = pagy(Orders::GetUserOrdersService.new(current_user, params).call, items: ORDERS_PER_PAGE)
  end

  def show; end
end
