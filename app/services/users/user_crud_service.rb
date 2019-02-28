class Users::UserCRUDService
  def initialize(user)
    @user = user
  end

  def update_email(email)
    @user.update(email: email) if email
  end
end
