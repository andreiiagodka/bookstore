class PagePresenter < Rectify::Presenter
  ERROR_CLASS = 'has-error'

  def current_url(get_params = nil)
    get_params ? request.params.merge(get_params) : request.params
  end

  def previous_url
    request.referer ? request.referer : root_path
  end

  def get_categories
    @categories ||= Category.all.decorate
  end

  def temporary_password
    @password ||= Devise.friendly_token
  end

  def set_error_class(object, param)
    ERROR_CLASS unless valid_param?(object, param)
  end

  def get_param_errors(object, param)
    object.errors.full_messages_for(param).to_sentence
  end

  def valid_param?(object, param)
    object.errors[param].empty?
  end
end
