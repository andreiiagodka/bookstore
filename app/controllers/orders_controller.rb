class OrdersController < ApplicationController
  load_and_authorize_resource

  decorates_assigned :order

  def show; end
end
