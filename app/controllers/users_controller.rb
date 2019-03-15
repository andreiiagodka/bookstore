class UsersController < ApplicationController
  load_and_authorize_resource

  def show; end

  def update
    if update_user_data
      flash[:success] = t('message.success.user.update')
      redirect_to root_path
    else
      render :show
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('message.success.user.destroy')
    else
      flash[:success] = @user.errors.full_messages.to_sentence
    end

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end

  def update_user_data
    user_params[:email].nil? ? @user.update_with_password(user_params) : @user.update(user_params)
  end
end
