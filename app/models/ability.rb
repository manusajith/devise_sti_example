class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_a? Admin
      can :manage, Post
    elsif user.is_a? Moderator
      can :manage, Post
      cannot :destroy, Post
      can :destroy, Post do |post|
        post.user == user
      end
    elsif user.is_a? Supervisor
      can :manage, Post
    elsif user.is_a? EndUserA
      can :manage, Post, user_id: user.id
    elsif user.is_a? Post
      can :manage, Post, user_id: user.id
      cannot :index, Post, used_id: user.id
    else
      cannot :manage, Post
    end
  end
end
