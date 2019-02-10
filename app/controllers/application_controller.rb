class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers

  before_action :categories
  before_action :initialize_page_presenter

  private

  def categories
    @categories = Category.all.decorate
  end

  def initialize_page_presenter
    @page_presenter = PagePresenter.new(request: request).attach_controller(self)
  end
end
