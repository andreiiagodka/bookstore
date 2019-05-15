class ErrorPresenter < Rectify::Presenter
  ERROR_CLASS = 'has-error'.freeze

  def initialize(entity)
    @entity = entity
  end

  def error_class(param)
    ERROR_CLASS unless valid_param?(param)
  end

  def get_param_errors(param)
    @entity.errors.full_messages_for(param).to_sentence
  end

  private

  def valid_param?(param)
    @entity.errors[param].empty?
  end
end
