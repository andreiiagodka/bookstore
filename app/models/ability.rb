class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :create, Review
    end

    can :manage, Book
    can :manage, OrderBook
  end
end
