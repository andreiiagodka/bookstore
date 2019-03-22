class OrdersController < ApplicationController
  load_resource only: :show
  authorize_resource

  ORDERS_PER_PAGE = 10

  include Rectify::ControllerHelpers
  include Pagy::Backend

  before_action :set_filtering_order, only: [:index]

  decorates_assigned :order

  def index
    # @pagy, @orders = pagy(current_user.orders.by_filtering_order(@filtering_order), items: ORDERS_PER_PAGE)
  end

  def show; end

  private

  def set_filtering_order
    @filtering_order = Orders::FilteringService.new(params[:filter]).call
  end
end
