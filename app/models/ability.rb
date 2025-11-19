class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: "customer") # guest

    if user.admin?
      # Admin can do anything
      can :manage, :all
    else
      # Guests & customers can browse the catalog
      can :read, Product
      can :read, ProductVariant

      if user.persisted?
        # Logged-in customer permissions (optional, keep or extend later)
        can :manage, CartItem, user_id: user.rut
        can :manage, Address,  user_id: user.rut if defined?(Address)
        can :read,   Order,    user_id: user.rut if defined?(Order)
      end
    end
  end
end
