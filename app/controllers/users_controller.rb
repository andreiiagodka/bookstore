class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :error_presenter

  def show; end

  def update
    if user_params[:email].present? ? @user.update(user_params) : @user.update_with_password(user_params)
      flash[:success] = t('message.success.user.update')
      redirect_to root_path and return
    else
      render :show
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('message.success.user.destroy')
      redirect_to root_path and return
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end

  def error_presenter
    @error_presenter ||= ErrorPresenter.new(@user).attach_controller(self)
  end
end
