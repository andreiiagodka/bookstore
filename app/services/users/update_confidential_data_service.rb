class Users::UpdateConfidentialDataService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    email_update_request? ? @user.update(@params) : @user.update_with_password(@params)
  end

  private

  def email_update_request?
    @params[:email].present?
  end
end
