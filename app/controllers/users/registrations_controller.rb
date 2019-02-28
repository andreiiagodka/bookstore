class Users::RegistrationsController < Devise::RegistrationsController
  before_action :initialize_crud_service, only: [:update]

  def update
    # @crud_service.update_email(params[:user][:email])

    redirect_to @page_presenter.previous_url
  end

  private

  def initialize_crud_service
    @crud_service = Users::UserCRUDService.new(current_user)
  end

  def user_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
