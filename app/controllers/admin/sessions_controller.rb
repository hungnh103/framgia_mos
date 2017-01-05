class Admin::SessionsController < Devise::SessionsController
  layout "session"

  def new
    super
  end

  def create
    user = User.find_by email: params[:admin_user][:email]
    (user && user.user? && user.roles_group.nil?) ? redirect_to(root_url) : super
  end

  def destroy
   super
  end

  private

  def after_sign_in_path_for _resource
    admin_root_path
  end

  def after_sign_out_path_for _resource
    admin_root_path
  end
end
