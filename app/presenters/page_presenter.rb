class PagePresenter < Rectify::Presenter
  def current_url(get_params = nil)
    get_params ? request.params.merge(get_params) : request.params
  end

  def previous_url
    request.referer || root_path
  end

  def temporary_password
    @temporary_password ||= Devise.friendly_token
  end
end
