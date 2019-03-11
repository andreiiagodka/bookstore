class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :create, Review
      can :manage, User
      can :manage, Address
    end

    can :manage, Book
    can :manage, Order
    can :manage, OrderBook
  end
end
