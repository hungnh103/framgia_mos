class Ability
  include CanCan::Ability

  def initialize user, namespace
    @user = user
    if namespace == "Admin"
      if @user.admin?
        can :manage, :all
        can :assign_roles, User, role: "user"
      elsif @user.roles_models.present?
        user_permissions
        cannot :block, User, id: @user.id
      end

      cannot :block, User, role: :admin
    elsif namespace == ""
      if @user
        can :manage, Post, user_id: @user.id
        can :manage, User, id: @user.id
      end
      can :read, :all
    end
  end

  private
  def user_permissions
    @user.roles_models.each do |roles_model|
      code = roles_model.code
      model_class = roles_model.model_class_name.constantize
      can BindRolesModelService.new(model_class).generate_roles(code), model_class
    end
  end
end
