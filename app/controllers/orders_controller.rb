class OrdersController < ApplicationController
  decorates_assigned :order

  before_action :get_order

  def show; end

  private

  def get_order
    @order ||= get_current_order
  end
end
