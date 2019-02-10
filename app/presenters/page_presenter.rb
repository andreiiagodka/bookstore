class PagePresenter < Rectify::Presenter
  def current_url(get_params = nil)
    get_params ? request.params.merge(get_params) : request.params
  end
end
