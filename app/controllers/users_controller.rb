class UsersController < ApplicationController
  load_and_authorize_resource

  def show; end

  def update
    if Users::UpdateConfidentialDataService.new(@user, user_params).call
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
end
