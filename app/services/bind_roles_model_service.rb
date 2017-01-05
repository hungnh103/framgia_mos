class BindRolesModelService
  def initialize model_class
    @model_class = model_class
  end

  def generate_code roles
    roles ||= []
    @code = 0
    roles.each do |role|
      @code = @code + 2**@model_class::ATTRIBUTES_ROLES.index(role.to_sym)
    end
    @code
  end

  def generate_roles code
    @code = code
    @action_roles = []
    generate_roles_from_code
    @action_roles.reverse!
  end

  private
  def generate_roles_from_code
    if @code > 0
      action_role_index = Math.log(@code, 2).to_i
      @action_roles << @model_class::ATTRIBUTES_ROLES[action_role_index]
      @code = @code - 2**action_role_index
      generate_roles_from_code
    end
  end
end
