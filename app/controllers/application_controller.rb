class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers

  before_action :initialize_page_presenter

  helper_method :current_order

  private

  def initialize_page_presenter
    @page_presenter = PagePresenter.new(request: request).attach_controller(self)
  end

  def current_order
    session[:order_id] = Order.create.id unless session[:order_id]

    Order.find_by(id: session[:order_id])
  end
end
