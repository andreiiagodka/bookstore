class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers
  include CurrentOrder

  before_action :initialize_page_presenter

  helper_method :get_current_order

  private

  def initialize_page_presenter
    @page_presenter = PagePresenter.new(request: request).attach_controller(self)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
