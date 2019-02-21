class OrdersController < ApplicationController
  decorates_assigned :order

  def show
    @order = get_current_order
  end
end
