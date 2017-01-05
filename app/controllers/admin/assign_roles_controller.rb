class Admin::AssignRolesController < Admin::BaseController
  load_resource :user
  before_action :authorize

  def new
  end

  def update
    @user.update_attribute :roles_group_id, params[:user][:roles_group_id]
    redirect_to [:admin, :users]
  end

  private
  def authorize
    authorize! :assign_roles, @user
  end
end
