class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers

  before_action :initialize_page_presenter

  helper_method :current_order

  private

  def initialize_page_presenter
    @page_presenter ||= PagePresenter.new(request: request).attach_controller(self)
  end

  def current_order
    @current_order ||= Order.find_by(id: session[:order_id]).decorate if session[:order_id]
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_order)
  end
end
