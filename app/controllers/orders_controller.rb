class OrdersController < ApplicationController
  decorates_assigned :order

  def show
    @order = current_order
  end
end
