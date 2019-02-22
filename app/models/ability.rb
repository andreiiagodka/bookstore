class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?

    else
      can :manage, Book 
    end

  end
end
