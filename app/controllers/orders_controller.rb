class OrdersController < ApplicationController
  load_resource only: :show
  authorize_resource

  ORDERS_PER_PAGE = 10

  include Rectify::ControllerHelpers
  include Pagy::Backend

  decorates_assigned :order

  def index
    @filtering_param = Orders::FilteringService.new(params[:filter]).call
    @pagy, @orders = pagy(current_user.orders.by_filter(@filtering_param), items: ORDERS_PER_PAGE)
  end

  def show; end
end
