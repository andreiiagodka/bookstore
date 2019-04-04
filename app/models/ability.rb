class Ability
  include CanCan::Ability

  def initialize(user, order)
    user ||= User.new

    if user.persisted?
      can :create, Review, user_id: user.id
      can [:show, :update, :destroy], User, id: user.id
      can [:create, :update], Address, addressable_id: user.id, addressable_type: 'User'
      can :index, Order
    end

    can :read, Review
    can :show, Order
    can [:index, :show], Book
    can [:create, :update, :destroy], OrderBook
  end
end
