class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :create, Review
      can :manage, User
      can :manage, Address
      can :manage, :checkout
    end

    can :home, :page

    can :manage, Book
    can :manage, Order
    can :manage, OrderBook
  end
end
