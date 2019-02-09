class ApplicationController < ActionController::Base
  before_action :categories

  private

  def categories
    @categories = Category.all.decorate
  end
end
