class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_role?(:administrador)
      can :manage, :all
    elsif user.is_role?(:moderador)
      can :manage, Category
      can :manage, Post
      can :manage, Archive
      can :read, User
      can :update, User do |u|
        u == user
      end  
    end
  end

end
